class Api::V1::TransactionsController < ApplicationController

    def get_all_apns
        @apn_codes = Transaction.select(:apn_code).group(:apn_code).having("count(*) >= 1")
        apn_only = @apn_codes.to_json(:only => [:apn_code])
        render json: apn_only
    end

    def get_dates
        # 2770000000062
        @trans_date = Transaction.select([:trans_date]).where(:apn_code => params[:apn_code])
        trans_date = @trans_date.to_json(:only => [:trans_date])
        render json: trans_date
    end

    def show
        @transaction = Transaction.where(:apn_code => params[:apn_code])
        render json: @transaction
    end
    
end
