from django.shortcuts import render_to_response
from django.http import HttpResponseRedirect
from django.template import RequestContext
from django.utils.translation import ugettext_lazy as _

from servers.models import Compute
from networks.forms import AddNetPool

from vrtManager.network import wvmNetwork, wvmNetworks
from vrtManager.network import network_size

from libvirt import libvirtError

from shared.helpers import render, redirect_or_json


def networks(request, host_id):
    """
    Networks block
    """
    errors = []
    object = {}

    try:
        compute = Compute.objects.get(id=host_id)

        conn = wvmNetworks(compute.hostname,
                           compute.login,
                           compute.password,
                           compute.type)
        networks = conn.get_networks_info()

        if request.method == 'POST':
            if 'create' in request.POST:
                form = AddNetPool(request.POST)
                if form.is_valid():
                    data = form.cleaned_data
                    if data['name'] in networks:
                        msg = _("Pool name already in use")
                        errors.append(msg)
                    if data['forward'] == 'bridge' and data['bridge_name'] == '':
                        errors.append('Please enter bridge name')
                    try:
                        gateway, netmask, dhcp = network_size(data['subnet'], data['dhcp'])
                    except:
                        msg = _("Input subnet pool error")
                        errors.append(msg)

                    if not errors:
                        try:
                            dns = None
                            dns_params = request.POST.get('dns')
                            if dns_params:
                                dns = dns_params.split(',')
                            conn.create_network(data['name'], data['forward'], gateway, netmask, dhcp,
                                                data['bridge_name'], data['openvswitch'], data['fixed'], dns)
                        except libvirtError as err:
                            errors.append(err)

                    object = {
                        'errors': [str(error) for error in errors],
                        'response': {}
                    }
                    url = '/%s/network/%s/' % (host_id, data['name'])
                    return redirect_or_json(object, url, request)

        conn.close()
    except Compute.DoesNotExist, e:
        object['errors'] = e.message
    except libvirtError as err:
        errors.append(err)
        object['errors'] = [str(error) for error in errors]

    return render(object, 'networks.html', locals(), request)


def network(request, host_id, pool):
    """
    Networks block
    """
    errors = []
    compute = Compute.objects.get(id=host_id)
    conn = None

    try:
        conn = wvmNetwork(compute.hostname,
                          compute.login,
                          compute.password,
                          compute.type,
                          pool)
        networks = conn.get_networks()
        state = conn.is_active()
        device = conn.get_bridge_device()
        autostart = conn.get_autostart()
        ipv4_forward = conn.get_ipv4_forward()
        ipv4_dhcp_range = conn.get_ipv4_dhcp_range()
        ipv4_network = conn.get_ipv4_network()
        fixed_address = conn.get_mac_ipaddr()

        object = {
            'errors': {},
            'response': {
                'networks': networks,
                'state': state,
                'device': device,
                'autostart': autostart,
                'ipv4_forward': ipv4_forward,
                'ipv4_dhcp_range': {
                    'start': str(ipv4_dhcp_range[0]) if ipv4_dhcp_range else None,
                    'end': str(ipv4_dhcp_range[1] if ipv4_dhcp_range else None)
                },
                'ipv4_network': str(ipv4_network),
                'fixed_address': fixed_address
            }
        }
    except libvirtError as err:
        errors.append(err)
        object = {
            'errors': [str(error) for error in errors]
        }

    if request.method == 'POST':
        if 'start' in request.POST:
            try:
                conn.start()
                return HttpResponseRedirect(request.get_full_path())
            except libvirtError as error_msg:
                errors.append(error_msg.message)
        if 'stop' in request.POST:
            try:
                conn.stop()
                return HttpResponseRedirect(request.get_full_path())
            except libvirtError as error_msg:
                errors.append(error_msg.message)
        if 'delete' in request.POST:
            try:
                conn.delete()
                return HttpResponseRedirect('/%s/networks' % host_id)
            except libvirtError as error_msg:
                errors.append(error_msg.message)
        if 'set_autostart' in request.POST:
            try:
                conn.set_autostart(1)
                return HttpResponseRedirect(request.get_full_path())
            except libvirtError as error_msg:
                errors.append(error_msg.message)
        if 'unset_autostart' in request.POST:
            try:
                conn.set_autostart(0)
                return HttpResponseRedirect(request.get_full_path())
            except libvirtError as error_msg:
                errors.append(error_msg.message)

    if conn:
        conn.close()

    return render(object, 'network.html', locals(), request)
