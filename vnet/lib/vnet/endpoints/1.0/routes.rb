# -*- coding: utf-8 -*-

Vnet::Endpoints::V10::VnetAPI.namespace '/routes' do

  post do
    params = parse_params(@params, ["uuid", "iface_uuid", "route_link_uuid", "ipv4_address", "ipv4_prefix"])

    if params.has_key?("uuid")
      raise E::DuplicateUUID, params["uuid"] unless M::Route[params["uuid"]].nil?
      params["uuid"] = M::Route.trim_uuid(params["uuid"])
    end

    iface_uuid = params.delete('iface_uuid') || raise(E::MissingArgument, 'iface_uuid')
    route_link_uuid = params.delete('route_link_uuid') || raise(E::MissingArgument, 'route_link_uuid')

    params['iface_id'] = (M::Iface[iface_uuid] || raise(E::InvalidUUID, iface_uuid)).id
    params['route_link_id'] = (M::RouteLink[route_link_uuid] || raise(E::InvalidUUID, route_link_uuid)).id

    params['ipv4_address'] = parse_ipv4(params['ipv4_address'] || raise(E::MissingArgument, 'ipv4_address'))

    route = M::Route.create(params)
    respond_with(R::Route.generate(route))
  end

  get do
    routes = M::Route.all
    respond_with(R::RouteCollection.generate(routes))
  end

  get '/:uuid' do
    route = M::Route[@params["uuid"]]
    respond_with(R::Route.generate(route))
  end

  delete '/:uuid' do
    route = M::Route.destroy(@params["uuid"])
    respond_with(R::Route.generate(route))
  end

  put '/:uuid' do
    params = parse_params(@params, ["ipv4_address","created_at","updated_at"])
    route = M::Route.update(@params["uuid"], params)
    respond_with(R::Route.generate(route))
  end
end
