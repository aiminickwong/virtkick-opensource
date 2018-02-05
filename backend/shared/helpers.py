from __future__ import print_function

from django.shortcuts import render_to_response
from django.http import HttpResponse, HttpResponseRedirect
from django.template import RequestContext
import json


class DateTimeEncoder(json.JSONEncoder):
    def default(self, obj):
       if hasattr(obj, 'isoformat'):
           return obj.isoformat()
       else:
           return json.JSONEncoder.default(self, obj)

def render(object, template, locals, request):
    if 'application/json' in request.META['HTTP_ACCEPT']:
        return HttpResponse(json.dumps(object, cls=DateTimeEncoder), content_type='application/json')
    else:
        return render_to_response(template, locals, context_instance=RequestContext(request))

def redirect_or_json(object, path, request):
    if 'application/json' in request.META['HTTP_ACCEPT']:
        return render(object, None, None, request)
    else:
        return HttpResponseRedirect(path)
