import sys
import time
import logging
import random
from jaeger_client import Config
from opentracing_instrumentation.request_context import get_current_span, span_in_context

def init_tracer(service):
    logging.getLogger('').handlers = []
    logging.basicConfig(format='%(message)s', level=logging.DEBUG)    
    config = Config(
        config={
            'sampler': {
                'type': 'const',
                'param': 1,
            },
            'logging': True,
        },
        service_name=service,
    )
    return config.initialize_tracer()

def booking_mgr(instance_name):
    with tracer.start_span('building') as span:
        span.set_tag('Instance', instance_name)
        with span_in_context(span):
            scheduling_details = scheduling(instance_name)
            networking_details = networking(scheduling_details)
            spawnling(networking_details)

def scheduling(instance_name):
    with tracer.start_span('scheduling', child_of=get_current_span()) as span:
        with span_in_context(span):
            num = random.randint(1,30)
            time.sleep(num)
            scheduling_details = "scheduling Details"
            flags = ['false', 'true', 'false']
            random_flag = random.choice(flags)
            span.set_tag('error', random_flag)
            span.log_kv({'event': 'scheduling' , 'value': scheduling_details })
            return scheduling_details

def networking( scheduling_details ):
    with tracer.start_span('Networking', child_of=get_current_span()) as span:
        with span_in_context(span):
            num = random.randint(1,30)
            time.sleep(num)
            networking_details = "Networking Details"
            flags = ['false', 'true', 'false']
            random_flag = random.choice(flags)
            span.set_tag('error', random_flag)
            span.log_kv({'event': 'Networking' , 'value': networking_details })
            return networking_details

def spawnling(networking_details):
    with tracer.start_span('Spawnling',  child_of=get_current_span()) as span:
        with span_in_context(span):
            num = random.randint(1,30)
            time.sleep(num)
            Ticket_details = "Spawnling Details"
            flags = ['false', 'true', 'false']
            random_flag = random.choice(flags)
            span.set_tag('error', random_flag)
            span.log_kv({'event': 'Spawnling' , 'value': networking_details })
            print(Ticket_details)

assert len(sys.argv) == 2
tracer = init_tracer('create_vm')
movie = sys.argv[1]
booking_mgr(movie)
# yield to IOLoop to flush the spans
time.sleep(2)
tracer.close()