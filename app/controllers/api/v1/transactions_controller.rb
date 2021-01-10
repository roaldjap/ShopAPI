class Api::V1::TransactionsController < ApplicationController
  def get_all_apns
    @apn_codes = Transaction.select(:apn_code).group(:apn_code).having("count(*) >= 1").pluck(:apn_code)
    apn_only = @apn_codes.to_json(:only => [:apn_code])

    render json: apn_only
  end

  def get_dates
    # 2770000000062
    @trans_date = Transaction.select([:trans_date]).where(:apn_code => params[:apn_code]).pluck(:trans_date)
    render json: @trans_date
  end

  def show
    @transactions = Transaction.where(:apn_code => params[:apn_code])
    # all_years = @transactions.select(:trans_date).map{ |item| item.trans_date.year }.uniq

    net_by_month = @transactions.select("DATE_TRUNC('month', trans_date) AS month, SUM(trans_total_ex_tax) AS ex_total_tax_per_month").group('month')
    
    # net_by_month = net_by_month.map{ |t|
    #   :year => t.trans_month,

    render json: net_by_month

  end


  # {
  #   labels: ['January', 'February'], // Months
  #   datasets: [
  #     {
  #       label: '2004', // Years
  #       data: [40, 0, 20 ,0 ,0 ,0, 0] //should be always 12
  #     },
  #     {
  #       label: '2005', // Year
  #       data: [40, 0, 20 ,0 ,0 ,0, 0] //should be always 12
  #     }
  #   ]
  # }

  # render json: @transactions.map{|t| {
  #   :year => t.trans_date.year,
  #   :month => t.trans_date.month,
  #   :profit => t.trans_total_ex_tax
  # }}
end
