---
title: kubernetes apiServer启动分析
date: 2017-10-09 23:03:14
tags: [k8s]
---
src: /home/liuzekun/github/kubernetes/cmd/kube-apiserver/app/options/options.go

# 简述
>>
apiserver是K8S最重要的组成部分，不论是命令操作还是通过remote
API进行控制，实际都需要经过apiserver。
apiserver是k8s系统中所有对象的增删改查盯的http/restful式服务端，其中盯是指watch操作。数据最终存储在分布式一致的etcd存储内，apiserver本身是无状态的，提供了这些数据访问的认证鉴权、缓存、api版本适配转换等一系列的功能。
// Package options contains flags and options for initializing an apiserver
package options

import (
	"net"
	"strings"
	"time"

    // 导入包时给包起别名
	utilnet "k8s.io/apimachinery/pkg/util/net"        
	genericoptions "k8s.io/apiserver/pkg/server/options"
	"k8s.io/apiserver/pkg/storage/storagebackend"
	"k8s.io/kubernetes/pkg/api"
	"k8s.io/kubernetes/pkg/api/validation"
	kubeoptions "k8s.io/kubernetes/pkg/kubeapiserver/options"
	kubeletclient "k8s.io/kubernetes/pkg/kubelet/client"
	"k8s.io/kubernetes/pkg/master/ports"
	"k8s.io/kubernetes/pkg/master/reconcilers"

	// add the kubernetes feature gates
    // _
    表只想执行一下某个代码包中的初始化函数，而不需要使用这个代码包中的任何程序实体
	_ "k8s.io/kubernetes/pkg/features"

	"github.com/spf13/pflag"
)

// DefaultServiceNodePortRange is the default port range for NodePort services.
var DefaultServiceNodePortRange = utilnet.PortRange{Base: 30000, Size: 2768}

// ServerRunOptions runs a kubernetes api server.
type ServerRunOptions struct {
	GenericServerRunOptions *genericoptions.ServerRunOptions        //服务器通用的运行参数
	Etcd                    *genericoptions.EtcdOptions
	SecureServing           *genericoptions.SecureServingOptions
	InsecureServing         *kubeoptions.InsecureServingOptions
	Audit                   *genericoptions.AuditOptions
	Features                *genericoptions.FeatureOptions
	Admission               *genericoptions.AdmissionOptions
	Authentication          *kubeoptions.BuiltInAuthenticationOptions
	Authorization           *kubeoptions.BuiltInAuthorizationOptions
	CloudProvider           *kubeoptions.CloudProviderOptions
	StorageSerialization    *kubeoptions.StorageSerializationOptions
	APIEnablement           *kubeoptions.APIEnablementOptions

	AllowPrivileged           bool    // 是否配置超级权限，即运行Pod中运行的容器拥有系统特权
	EnableLogsHandler         bool
	EventTTL                  time.Duration  // 事件留存事件，默认1h
	KubeletConfig             kubeletclient.KubeletClientConfig
	KubernetesServiceNodePort int
	MaxConnectionBytesPerSec  int64
	ServiceClusterIPRange     net.IPNet // TODO: make this a list
	ServiceNodePortRange      utilnet.PortRange
	SSHKeyfile                string
	SSHUser                   string

	ProxyClientCertFile string
	ProxyClientKeyFile  string

	EnableAggregatorRouting bool

	MasterCount            int
	EndpointReconcilerType string
}

// NewServerRunOptions creates a new ServerRunOptions object with default parameters
func NewServerRunOptions() *ServerRunOptions {
	s := ServerRunOptions{
		GenericServerRunOptions: genericoptions.NewServerRunOptions(),
		Etcd:                 genericoptions.NewEtcdOptions(storagebackend.NewDefaultConfig(kubeoptions.DefaultEtcdPathPrefix, api.Scheme, nil)),
		SecureServing:        kubeoptions.NewSecureServingOptions(),
		InsecureServing:      kubeoptions.NewInsecureServingOptions(),
		Audit:                genericoptions.NewAuditOptions(),
		Features:             genericoptions.NewFeatureOptions(),
		Admission:            genericoptions.NewAdmissionOptions(),
		Authentication:       kubeoptions.NewBuiltInAuthenticationOptions().WithAll(),
		Authorization:        kubeoptions.NewBuiltInAuthorizationOptions(),
		CloudProvider:        kubeoptions.NewCloudProviderOptions(),
		StorageSerialization: kubeoptions.NewStorageSerializationOptions(),
		APIEnablement:        kubeoptions.NewAPIEnablementOptions(),

		EnableLogsHandler:      true,
		EventTTL:               1 * time.Hour,
		MasterCount:            1,
		EndpointReconcilerType: string(reconcilers.MasterCountReconcilerType),
		KubeletConfig: kubeletclient.KubeletClientConfig{
			Port:         ports.KubeletPort,
			ReadOnlyPort: ports.KubeletReadOnlyPort,
			PreferredAddressTypes: []string{
				// --override-hostname
				string(api.NodeHostName),

				// internal, preferring DNS if reported
				string(api.NodeInternalDNS),
				string(api.NodeInternalIP),

				// external, preferring DNS if reported
				string(api.NodeExternalDNS),
				string(api.NodeExternalIP),
			},
			EnableHttps: true,
			HTTPTimeout: time.Duration(5) * time.Second,
		},
		ServiceNodePortRange: DefaultServiceNodePortRange,
	}
	// Overwrite the default for storage data format.
	s.Etcd.DefaultStorageMediaType = "application/vnd.kubernetes.protobuf"

	// register all admission plugins
	RegisterAllAdmissionPlugins(s.Admission.Plugins)
	// Set the default for admission plugins names
	s.Admission.PluginNames = []string{"AlwaysAdmit"}
	return &s
}

// AddFlags adds flags for a specific APIServer to the specified FlagSet
func (s *ServerRunOptions) AddFlags(fs *pflag.FlagSet) {
	// Add the generic flags.
	s.GenericServerRunOptions.AddUniversalFlags(fs)
	s.Etcd.AddFlags(fs)
	s.SecureServing.AddFlags(fs)
	s.SecureServing.AddDeprecatedFlags(fs)
	s.InsecureServing.AddFlags(fs)
	s.InsecureServing.AddDeprecatedFlags(fs)
	s.Audit.AddFlags(fs)
	s.Features.AddFlags(fs)
	s.Authentication.AddFlags(fs)
	s.Authorization.AddFlags(fs)
	s.CloudProvider.AddFlags(fs)
	s.StorageSerialization.AddFlags(fs)
	s.APIEnablement.AddFlags(fs)
	s.Admission.AddFlags(fs)

	// Note: the weird ""+ in below lines seems to be the only way to get gofmt to
	// arrange these text blocks sensibly. Grrr.

	fs.DurationVar(&s.EventTTL, "event-ttl", s.EventTTL,
		"Amount of time to retain events.")

	fs.BoolVar(&s.AllowPrivileged, "allow-privileged", s.AllowPrivileged,
		"If true, allow privileged containers. [default=false]")

	fs.BoolVar(&s.EnableLogsHandler, "enable-logs-handler", s.EnableLogsHandler,
		"If true, install a /logs handler for the apiserver logs.")

	fs.StringVar(&s.SSHUser, "ssh-user", s.SSHUser,
		"If non-empty, use secure SSH proxy to the nodes, using this user name")

	fs.StringVar(&s.SSHKeyfile, "ssh-keyfile", s.SSHKeyfile,
		"If non-empty, use secure SSH proxy to the nodes, using this user keyfile")

	fs.Int64Var(&s.MaxConnectionBytesPerSec, "max-connection-bytes-per-sec", s.MaxConnectionBytesPerSec, ""+
		"If non-zero, throttle each user connection to this number of bytes/sec. "+
		"Currently only applies to long-running requests.")

	fs.IntVar(&s.MasterCount, "apiserver-count", s.MasterCount,
		"The number of apiservers running in the cluster, must be a positive number.")

	fs.StringVar(&s.EndpointReconcilerType, "alpha-endpoint-reconciler-type", string(s.EndpointReconcilerType),
		"Use an endpoint reconciler ("+strings.Join(reconcilers.AllTypes.Names(), ", ")+")")

	// See #14282 for details on how to test/try this option out.
	// TODO: remove this comment once this option is tested in CI.
	fs.IntVar(&s.KubernetesServiceNodePort, "kubernetes-service-node-port", s.KubernetesServiceNodePort, ""+
		"If non-zero, the Kubernetes master service (which apiserver creates/maintains) will be "+
		"of type NodePort, using this as the value of the port. If zero, the Kubernetes master "+
		"service will be of type ClusterIP.")

	fs.IPNetVar(&s.ServiceClusterIPRange, "service-cluster-ip-range", s.ServiceClusterIPRange, ""+
		"A CIDR notation IP range from which to assign service cluster IPs. This must not "+
		"overlap with any IP ranges assigned to nodes for pods.")

	fs.IPNetVar(&s.ServiceClusterIPRange, "portal-net", s.ServiceClusterIPRange,
		"DEPRECATED: see --service-cluster-ip-range instead.")
	fs.MarkDeprecated("portal-net", "see --service-cluster-ip-range instead")

	fs.Var(&s.ServiceNodePortRange, "service-node-port-range", ""+
		"A port range to reserve for services with NodePort visibility. "+
		"Example: '30000-32767'. Inclusive at both ends of the range.")
	fs.Var(&s.ServiceNodePortRange, "service-node-ports", "DEPRECATED: see --service-node-port-range instead")
	fs.MarkDeprecated("service-node-ports", "see --service-node-port-range instead")

	// Kubelet related flags:
	fs.BoolVar(&s.KubeletConfig.EnableHttps, "kubelet-https", s.KubeletConfig.EnableHttps,
		"Use https for kubelet connections.")

	fs.StringSliceVar(&s.KubeletConfig.PreferredAddressTypes, "kubelet-preferred-address-types", s.KubeletConfig.PreferredAddressTypes,
		"List of the preferred NodeAddressTypes to use for kubelet connections.")

	fs.UintVar(&s.KubeletConfig.Port, "kubelet-port", s.KubeletConfig.Port,
		"DEPRECATED: kubelet port.")
	fs.MarkDeprecated("kubelet-port", "kubelet-port is deprecated and will be removed.")

	fs.UintVar(&s.KubeletConfig.ReadOnlyPort, "kubelet-read-only-port", s.KubeletConfig.ReadOnlyPort,
		"DEPRECATED: kubelet port.")

	fs.DurationVar(&s.KubeletConfig.HTTPTimeout, "kubelet-timeout", s.KubeletConfig.HTTPTimeout,
		"Timeout for kubelet operations.")

	fs.StringVar(&s.KubeletConfig.CertFile, "kubelet-client-certificate", s.KubeletConfig.CertFile,
		"Path to a client cert file for TLS.")

	fs.StringVar(&s.KubeletConfig.KeyFile, "kubelet-client-key", s.KubeletConfig.KeyFile,
		"Path to a client key file for TLS.")

	fs.StringVar(&s.KubeletConfig.CAFile, "kubelet-certificate-authority", s.KubeletConfig.CAFile,
		"Path to a cert file for the certificate authority.")

	// TODO: delete this flag as soon as we identify and fix all clients that send malformed updates, like #14126.
	fs.BoolVar(&validation.RepairMalformedUpdates, "repair-malformed-updates", validation.RepairMalformedUpdates, ""+
		"If true, server will do its best to fix the update request to pass the validation, "+
		"e.g., setting empty UID in update request to its existing value. This flag can be turned off "+
		"after we fix all the clients that send malformed updates.")

	fs.StringVar(&s.ProxyClientCertFile, "proxy-client-cert-file", s.ProxyClientCertFile, ""+
		"Client certificate used to prove the identity of the aggregator or kube-apiserver "+
		"when it must call out during a request. This includes proxying requests to a user "+
		"api-server and calling out to webhook admission plugins. It is expected that this "+
		"cert includes a signature from the CA in the --requestheader-client-ca-file flag. "+
		"That CA is published in the 'extension-apiserver-authentication' configmap in "+
		"the kube-system namespace. Components recieving calls from kube-aggregator should "+
		"use that CA to perform their half of the mutual TLS verification.")
	fs.StringVar(&s.ProxyClientKeyFile, "proxy-client-key-file", s.ProxyClientKeyFile, ""+
		"Private key for the client certificate used to prove the identity of the aggregator or kube-apiserver "+
		"when it must call out during a request. This includes proxying requests to a user "+
		"api-server and calling out to webhook admission plugins.")

	fs.BoolVar(&s.EnableAggregatorRouting, "enable-aggregator-routing", s.EnableAggregatorRouting,
		"Turns on aggregator routing requests to endoints IP rather than cluster IP.")

}
