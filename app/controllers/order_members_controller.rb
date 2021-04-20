class OrderMembersController < ApplicationController
    def index
        @orders_members = OrderMember.where(user_id: current_user.id)
      end
    
      def show
        
      end
    
      def new
        
      end
    
      def create

      end
end
