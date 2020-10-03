
2019-11-08 11:39:34.971 12881 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:39:34.972 12881 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:39:34.972 12881 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:39:34.972 12881 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:39:34.972 12881 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:39:34.972 12881 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:39:34.973 12881 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:39:34.973 12881 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:39:34.973 12881 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:34.974 12881 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:34.974 12881 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:39:34.975 12881 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:39:34.975 12881 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:34.975 12881 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:34.976 12881 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:39:34.976 12881 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:39:34.976 12881 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:39:34.976 12881 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:39:34.977 12881 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:39:34.977 12881 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:39:34.977 12881 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>[app_name=keystone-public]
2019-11-08 11:39:34.977 12881 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>
2019-11-08 11:39:37.242 12870 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:39:37.243 12870 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:39:37.243 12870 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:39:37.243 12870 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:39:37.243 12870 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:39:37.243 12870 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:39:37.244 12870 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:39:37.244 12870 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:39:37.245 12870 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:37.245 12870 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:37.245 12870 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:39:37.246 12870 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:39:37.246 12870 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:37.246 12870 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:37.246 12870 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:39:37.247 12870 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:39:37.247 12870 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:39:37.247 12870 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:39:37.248 12870 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:39:37.248 12870 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:39:37.248 12870 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>[app_name=keystone-public]
2019-11-08 11:39:37.248 12870 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>
2019-11-08 11:39:40.056 12917 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:39:40.057 12917 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:39:40.057 12917 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:39:40.057 12917 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:39:40.057 12917 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:39:40.058 12917 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:39:40.058 12917 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:39:40.058 12917 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:39:40.059 12917 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:40.059 12917 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:40.059 12917 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:39:40.060 12917 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:39:40.060 12917 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:40.060 12917 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:39:40.060 12917 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:39:40.060 12917 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:39:40.061 12917 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:39:40.061 12917 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:39:40.061 12917 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:39:40.062 12917 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:39:40.062 12917 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>[app_name=keystone-public]
2019-11-08 11:39:40.062 12917 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>
2019-11-08 11:40:15.323 12888 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:40:15.324 12888 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:40:15.324 12888 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:40:15.324 12888 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:40:15.324 12888 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:40:15.325 12888 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:40:15.325 12888 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:40:15.325 12888 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:40:15.326 12888 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:15.326 12888 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:15.327 12888 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:40:15.327 12888 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:40:15.327 12888 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:15.328 12888 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:15.328 12888 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:40:15.328 12888 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:40:15.328 12888 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:40:15.328 12888 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:40:15.329 12888 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:40:15.330 12888 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:40:15.330 12888 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>[app_name=keystone-public]
2019-11-08 11:40:15.330 12888 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>
2019-11-08 11:40:18.136 12934 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:40:18.137 12934 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:40:18.137 12934 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:40:18.137 12934 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:40:18.138 12934 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:40:18.138 12934 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:40:18.138 12934 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:40:18.138 12934 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:40:18.139 12934 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:18.140 12934 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:18.140 12934 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:40:18.140 12934 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:40:18.141 12934 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:18.141 12934 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:18.141 12934 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:40:18.142 12934 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:40:18.142 12934 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:40:18.142 12934 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:40:18.143 12934 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:40:18.143 12934 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:40:18.143 12934 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76ed0>[app_name=keystone-public]
2019-11-08 11:40:18.143 12934 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76ed0>
2019-11-08 11:40:36.881 12909 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:40:36.882 12909 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:40:36.882 12909 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:40:36.882 12909 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:40:36.882 12909 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:40:36.882 12909 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:40:36.883 12909 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:40:36.883 12909 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:40:36.883 12909 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:36.884 12909 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:36.884 12909 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:40:36.884 12909 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:40:36.885 12909 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:36.885 12909 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:36.885 12909 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:40:36.885 12909 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:40:36.886 12909 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:40:36.886 12909 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:40:36.886 12909 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:40:36.887 12909 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:40:36.887 12909 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>[app_name=keystone-public]
2019-11-08 11:40:36.887 12909 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>
2019-11-08 11:40:39.099 12925 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:40:39.099 12925 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:40:39.099 12925 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:40:39.100 12925 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:40:39.100 12925 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:40:39.100 12925 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:40:39.100 12925 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:40:39.101 12925 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:40:39.101 12925 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:39.102 12925 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:39.102 12925 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:40:39.102 12925 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:40:39.103 12925 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:39.103 12925 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:39.103 12925 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:40:39.104 12925 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:40:39.104 12925 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:40:39.104 12925 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:40:39.105 12925 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:40:39.105 12925 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:40:39.105 12925 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76ed0>[app_name=keystone-public]
2019-11-08 11:40:39.105 12925 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76ed0>
2019-11-08 11:40:41.945 12946 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:40:41.946 12946 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:40:41.946 12946 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:40:41.946 12946 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:40:41.946 12946 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:40:41.946 12946 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:40:41.946 12946 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:40:41.947 12946 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:40:41.948 12946 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:41.948 12946 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:41.948 12946 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:40:41.949 12946 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:40:41.949 12946 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:41.949 12946 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:40:41.949 12946 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:40:41.950 12946 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:40:41.950 12946 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:40:41.950 12946 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:40:41.951 12946 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:40:41.951 12946 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:40:41.951 12946 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>[app_name=keystone-public]
2019-11-08 11:40:41.951 12946 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>
2019-11-08 11:41:17.270 12892 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:41:17.271 12892 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:41:17.271 12892 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:41:17.271 12892 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:41:17.271 12892 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:41:17.271 12892 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:41:17.272 12892 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:41:17.272 12892 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:41:17.273 12892 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:17.273 12892 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:17.273 12892 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:41:17.273 12892 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:41:17.274 12892 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:17.274 12892 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:17.274 12892 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:41:17.275 12892 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:41:17.275 12892 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:41:17.275 12892 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:41:17.276 12892 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:41:17.276 12892 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:41:17.276 12892 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>[app_name=keystone-public]
2019-11-08 11:41:17.276 12892 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>
2019-11-08 11:41:20.016 12957 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:41:20.017 12957 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:41:20.017 12957 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:41:20.017 12957 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:41:20.017 12957 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:41:20.017 12957 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:41:20.018 12957 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:41:20.018 12957 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:41:20.019 12957 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:20.019 12957 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:20.019 12957 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:41:20.019 12957 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:41:20.020 12957 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:20.020 12957 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:20.020 12957 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:41:20.020 12957 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:41:20.021 12957 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:41:20.021 12957 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:41:20.022 12957 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:41:20.022 12957 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:41:20.022 12957 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>[app_name=keystone-public]
2019-11-08 11:41:20.022 12957 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>
2019-11-08 11:41:38.525 12869 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:41:38.526 12869 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:41:38.526 12869 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:41:38.526 12869 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:41:38.526 12869 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:41:38.527 12869 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:41:38.527 12869 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:41:38.527 12869 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:41:38.528 12869 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:38.528 12869 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:38.529 12869 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:41:38.529 12869 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:41:38.529 12869 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:38.530 12869 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:41:38.530 12869 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:41:38.530 12869 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:41:38.530 12869 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:41:38.531 12869 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:41:38.531 12869 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:41:38.532 12869 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:41:38.532 12869 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76ed0>[app_name=keystone-public]
2019-11-08 11:41:38.532 12869 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76ed0>
2019-11-08 11:42:19.852 12843 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:42:19.853 12843 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:42:19.853 12843 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:42:19.853 12843 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:42:19.853 12843 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:42:19.853 12843 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:42:19.854 12843 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:42:19.854 12843 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:42:19.855 12843 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:19.855 12843 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:19.856 12843 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:42:19.856 12843 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:42:19.856 12843 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:19.857 12843 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:19.857 12843 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:42:19.857 12843 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:42:19.857 12843 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:42:19.858 12843 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:42:19.858 12843 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:42:19.859 12843 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:42:19.859 12843 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76ed0>[app_name=keystone-public]
2019-11-08 11:42:19.859 12843 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76ed0>
2019-11-08 11:42:39.917 12896 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:42:39.917 12896 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:42:39.918 12896 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:42:39.918 12896 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:42:39.918 12896 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:42:39.918 12896 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:42:39.918 12896 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:42:39.919 12896 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:42:39.920 12896 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:39.920 12896 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:39.920 12896 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:42:39.921 12896 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:42:39.921 12896 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:39.921 12896 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:39.921 12896 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:42:39.922 12896 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:42:39.922 12896 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:42:39.922 12896 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:42:39.923 12896 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:42:39.923 12896 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:42:39.923 12896 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>[app_name=keystone-public]
2019-11-08 11:42:39.923 12896 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>
2019-11-08 11:42:42.747 12924 INFO jaeger_tracing [-] Config.py init keystone-public config = {'logging': True, 'local_agent': {'reporting_host': '127.0.0.1', 'reporting_port': 6831}, 'sampler': {'type': 'const', 'param': 1}}
2019-11-08 11:42:42.748 12924 INFO jaeger_tracing [-] Config.py: new_tracer io = None
2019-11-08 11:42:42.748 12924 INFO jaeger_tracing [-] Initializing Jaeger Tracer with UDP reporter
2019-11-08 11:42:42.748 12924 INFO jaeger_tracing local_agent_net.py [-] init io_loop = None tornado ver = 4.5.3
2019-11-08 11:42:42.748 12924 INFO jaeger_tracing local_agent_net.py [-] create thread loop: <threadloop.threadloop.ThreadLoop object at 0x7fa222c76850>
2019-11-08 11:42:42.748 12924 INFO jaeger_tracing local_agent_net.py [-] select <module 'select' from '/usr/lib64/python2.7/lib-dynload/selectmodule.so'> => epoll: True, kqueue = False
2019-11-08 11:42:42.748 12924 INFO jaeger_tracing local_agent_net.py [-] thread loop not ready
2019-11-08 11:42:42.749 12924 INFO jaeger_threadloop [-] _start io loop: None
2019-11-08 11:42:42.749 12924 INFO jaeger_threadloop [-] before start io_loop: <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:42.750 12924 INFO jaeger_tracing local_agent_net.py [-] self io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:42.750 12924 INFO jaeger_tracing [-] Using sampler ConstSampler(True)
2019-11-08 11:42:42.750 12924 INFO jaeger_tracing [-] Reporter.py channel init: <jaeger_client.local_agent_net.LocalAgentSender object at 0x7fa222c768d0>
2019-11-08 11:42:42.751 12924 INFO jaeger_tracing [-] Reporter.py io_loop init : None vs <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:42.751 12924 INFO jaeger_tracing [-] Reporter.py io_loop = <tornado.platform.epoll.EPollIOLoop object at 0x7fa222c76ad0>
2019-11-08 11:42:42.751 12924 INFO jaeger_tracing [-] Reporter.py add consume queue to io loop spawn callback
2019-11-08 11:42:42.751 12924 INFO jaeger_tracing [-] Reporter.py init end
2019-11-08 11:42:42.752 12924 INFO jaeger_tracing [-] Reporter.py _consume queue
2019-11-08 11:42:42.752 12924 INFO jaeger_tracing [-] Config.py init_tracer <jaeger_client.reporter.CompositeReporter object at 0x7fa222c76e90>
2019-11-08 11:42:42.753 12924 INFO jaeger_tracing [-] Reporter.py set_process: keystone-public | {u'ip': '172.16.29.146', u'jaeger.version': u'Python-4.1.0', u'hostname': 'controller02'}
2019-11-08 11:42:42.753 12924 INFO jaeger_tracing [-] Tracer.py inited keystone-public
2019-11-08 11:42:42.753 12924 INFO jaeger_tracing [-] opentracing.tracer initialized to <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>[app_name=keystone-public]
2019-11-08 11:42:42.753 12924 INFO jaeger_osprofiler [-] Jaeger init init tracer: <jaeger_client.tracer.Tracer object at 0x7fa222c76fd0>
2019-11-08 11:42:47.651