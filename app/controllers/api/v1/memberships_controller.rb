module Api
  module V1
    class MembershipsController < ApplicationController
      before_action :set_membership, only: %i[ show update destroy ]

      # GET /memberships
      def index
        @memberships = Membership.all

        render json: @memberships
      end

      # GET /memberships/1
      def show
        render json: @membership
      end

      # POST /memberships
      def create
        @membership = current_user.memberships.build(membership_params)

        if @membership.save
          render json: @membership, status: :created
        else
          render json: @membership.errors, status: :unprocessable_content
        end
      end

      # PATCH/PUT /memberships/1
      def update
        if @membership.update(membership_params)
          render json: @membership
        else
          render json: @membership.errors, status: :unprocessable_content
        end
      end

      # DELETE /memberships/1
      def destroy
        @membership.destroy!
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_membership
          @membership = Membership.find(params.expect(:id))
        end

        # Only allow a list of trusted parameters through.
        def membership_params
          params.expect(membership: [ :role ])
        end
    end
  end
end