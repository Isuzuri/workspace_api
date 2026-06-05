module Api
  module V1
    class WorkspacesController < ApplicationController
      before_action :set_workspace, only: %i[ show update destroy ]

      # GET /workspaces
      def index
        @workspaces = Workspace.all

        render json: @workspaces
      end

      # GET /workspaces/1
      def show
        render json: @workspace
      end

      # POST /workspaces
      def create
        @workspace = current_user.owned_workspaces.build(workspace_params)

        if @workspace.save
          render json: @workspace, status: :created
        else
          render json: @workspace.errors, status: :unprocessable_content
        end
      end

      # PATCH/PUT /workspaces/1
      def update
        if @workspace.update(workspace_params)
          render json: @workspace
        else
          render json: @workspace.errors, status: :unprocessable_content
        end
      end

      # DELETE /workspaces/1
      def destroy
        @workspace.destroy!
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_workspace
          @workspace = current_user.workspaces.find(params.expect(:id))
        end

        # Only allow a list of trusted parameters through.
        def workspace_params
          params.expect(workspace: [ :name, :description ])
        end
    end
  end
end
