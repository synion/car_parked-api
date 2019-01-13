module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      before_action :authorize_application
      respond_to :json

      def create
        build_resource(JSON.parse(request.raw_post)["user"])

        resource.save
        render_resource(resource)
      end

      private

      def authorize_application
        AuthorizeApplication.call(request.headers)
      rescue AuthorizeApplication::Error
        render status: 401, json: "Application unauthorized"
      end
    end
  end
end
