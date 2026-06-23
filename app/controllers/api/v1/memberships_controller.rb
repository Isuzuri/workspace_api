module Api
  module V1
    class MembershipsController < ApplicationController
      before_action :set_workspace, only: %i[ index create update destroy ]

      def index
        authorize @workspace
        render json: @workspace.memberships
      end

      def create
        return head :no_content if @workspace.memberships.exists?(user_id: params[:user_id])

        authorize @workspace

        @workspace.memberships.create!(membership_params)
        head :no_content
      end

      def update
        membership = @workspace.memberships.find(params[:id])

        authorize membership

        membership.update!(role: params[:role])
        head :no_content
      end

      def destroy
        membership = @workspace.memberships.find(params[:id])

        authorize membership

        membership.destroy!
        head :no_content
      end

      private

      def set_workspace
        @workspace = current_user.workspaces.find(params[:workspace_id])
      end

      def membership_params
        params.require(:membership).permit(:user_id, :role)
      end
    end
  end
end
