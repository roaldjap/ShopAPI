class Api::V1::TransactionsController < ApplicationController

    def show
        # @transaction = Transaction.find(params[:apn_code])
        @transaction = Transaction.where(:apn_code => params[:apn_code])
        render json: @transaction
    end

    private

    def get_all_apn_codes
        @apn_codes = Transaction.select(:apn_code).having("count(*) > 1")
    end
    

    # def transaction_params
    #     params.require(:transaction).permit()
    # end
end
