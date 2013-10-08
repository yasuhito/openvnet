# -*- coding: utf-8 -*-

Vnet::Endpoints::V10::VnetAPI.namespace '/security_groups' do
  put_post_shared_params = [
    "display_name",
    "description"
  ]

  post do
    accepted_params = put_post_shared_params + ["uuid"]
    required_params = ["display_name"]

    post_new(:SecurityGroup, accepted_params, required_params)
  end

  get do
    get_all :SecurityGroup
  end

  get '/:uuid' do
    get_by_uuid :SecurityGroup
  end

  delete '/:uuid' do
    delete_by_uuid :SecurityGroup
  end

  put '/:uuid' do
    update_by_uuid(:SecurityGroup, put_post_shared_params)
  end
end
