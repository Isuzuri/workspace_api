module Api
  module V1
    class WorkspacesController < ApplicationController
      before_action :set_workspace, only: %i[ show update destroy ]

      def index
        @workspaces = current_user.workspaces
        render json: @workspaces
      end

      def show
        authorize @workspace
        render json: @workspace
      end

      def create
        @workspace = Workspaces::CreateService.new(user: current_user, params: workspace_params).call
        render json: @workspace, status: :created
      end

      def update
        authorize @workspace

        @workspace.update!(workspace_params)
        render json: @workspace
      end

      def destroy
        authorize @workspace

        @workspace.destroy!
        head :no_content
      end

      private

      def set_workspace
        @workspace = current_user.workspaces.find(params[:id])
      end

      def workspace_params
        params.require(:workspace).permit(:name, :description)
      end
    end
  end
end
