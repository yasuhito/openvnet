# -*- coding: utf-8 -*-

require 'trema/mac'

Vnet::Endpoints::V10::VnetAPI.namespace '/interfaces' do
  put_post_shared_params = [
    "network_uuid",
    "owner_datapath_uuid",
    "mode",
  ]

  post do
    accepted_params = put_post_shared_params + ["uuid"]
    required_params = []

    post_new(:Interface, accepted_params, required_params) { |params|
      check_syntax_and_get_id(M::Network, params, "network_uuid", "network_id") if params["network_uuid"]
      check_syntax_and_get_id(M::Datapath, params, "owner_datapath_uuid", "owner_datapath_id") if params["owner_datapath_uuid"]
    }
  end

  get do
    get_all(:Interface)
  end

  get '/:uuid' do
    get_by_uuid(:Interface)
  end

  delete '/:uuid' do
    delete_by_uuid(:Interface)
  end

  put '/:uuid' do
    update_by_uuid(:Interface, put_post_shared_params) { |params|
      check_syntax_and_get_id(M::Network, params, "network_uuid", "network_id") if params["network_uuid"]
      check_syntax_and_get_id(M::Datapath, params, "owner_datapath_uuid", "owner_datapath_id") if params["owner_datapath_uuid"]
    }
  end
end
