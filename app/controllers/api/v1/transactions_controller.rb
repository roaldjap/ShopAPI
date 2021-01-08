class Api::V1::TransactionsController < ApplicationController

    def get_all_apns
        @apn_codes = Transaction.select(:apn_code).group(:apn_code).having("count(*) >= 1")
        apn = @apn_codes.to_json(:only => [ :apn_code ])
        render json: apn
    end

    def show
        # @transaction = Transaction.find(params[:apn_code])
        @transaction = Transaction.where(:apn_code => params[:apn_code])
        render json: @transaction
    end
    
end
