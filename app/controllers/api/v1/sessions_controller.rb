module Api
  module V1
    class SessionsController < Devise::SessionsController
      before_action :authorize_application
      respond_to :json

      def create
        self.resource = warden.authenticate!(auth_options.merge(scope: :user))
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      end

      private

      def respond_with(resource, _opts = {})
        render json: resource
      end

      def respond_to_on_destroy
        head :no_content
      end

      def authorize_application
        AuthorizeApplication.call(request.headers)
      rescue AuthorizeApplication::Error
        render status: 401, json: "Application unauthorized"
      end
    end
  end
end
