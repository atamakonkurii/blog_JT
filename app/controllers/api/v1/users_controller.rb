module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[show]
      before_action :set_user
      before_action :set_user_json

      def show
        render json: set_user_json
      end

      def set_user
        @user = User.find(params[:id])
      end

      def set_user_json
        serializer = UserSerializer.new(@user)
        serializer.serializable_hash.to_json
      end
    end
  end
end
