module Api
  module V1
    class MembershipsController < ApplicationController
      before_action :set_workspace, only: %i[ index invite exclude change_role ]

      def index
        authorize @workspace, :index?
        render json: @workspace.memberships
      end

      def invite
        membership = @workspace.memberships.find_by(user: user)
        return membership if membership
        authorize membership

        @workspace.memberships.create!(user: user, role: role)
        render json: { status: 'ok'}
      end

      def exclude
        membership = @workspace.memberships.find(params[:id])
        raise ActiveRecord::RecordNotFound unless membership
        authorize membership

        membership.destroy!
        render json: { status: 'ok'}
      end

      def change_role
        membership = @workspace.memberships.find(params[:id])
        raise ActiveRecord::RecordNotFound unless membership
        authorize membership

        membership.update!(role: role)
        render json: { status: 'ok'}
      end

      private 

      def set_workspace
        @workspace = current_user.workspaces.find(params[:workspace_id])
      end

      def user 
        @user ||= User.find(params[:user_id])
      end

      def role
        params[:role]
      end
    end
  end
end