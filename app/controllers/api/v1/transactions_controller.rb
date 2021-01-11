class Api::V1::TransactionsController < ApplicationController
  def get_all_apns
    @apn_codes = Transaction.select(:apn_code).group(:apn_code).having("count(*) >= 1").pluck(:apn_code)
    apn_only = @apn_codes.to_json(:only => [:apn_code])

    render json: apn_only
  end

  def line_graph
    @transactions = Transaction.where(:apn_code => params[:apn_code])
    
    net_by_year = @transactions.select("DATE_TRUNC('year', trans_date) AS year, SUM(trans_total_ex_tax) net_per_year, SUM(trans_total_tax) tax_per_year").group('year')
    net_by_month = @transactions.select("DATE_TRUNC('month', trans_date) AS month, SUM(trans_total_ex_tax) AS net_per_month").group('month')
   
    yom = net_by_month.map{ |t| {:year => t.month.year, :month => t.month.month, :sales => t.net_per_month}} 
   
    result = net_by_year.map do |i|

      data = Array(1..12).map do |month|
        net_hash = yom.find{ |sales_per_month| sales_per_month[:year] == i.year.year && sales_per_month[:month] == month}
        net_hash ? net_hash[:sales] : 0
      end

      {
        :label => i.year.year,
        :data => data,
        :backgroundColor => get_rand_color
      }
    end

    render json: result
  end

  def bar_graph
    @transactions = Transaction.where(:apn_code => params[:apn_code])
    
    net_by_year = @transactions.select("DATE_TRUNC('year', trans_date) AS year, SUM(trans_total_ex_tax) net_per_year, SUM(trans_total_tax) tax_per_year").group('year')
   
   
    # result = net_by_year.map do |i|
      
    #   {
    #     :labels => i.year.year,
    #     :data => data,
    #     :backgroundColor => get_rand_color
    #   }
    # end

    # this.chartData = {
    #   labels: [
    #     // years
    #   ], 
    #   datasets: data,
    # };

    render json: net_by_year
  end

  private
  def get_rand_color
    a = "#E6"
    r = rand(255).to_s(16)
    g = rand(255).to_s(16)
    b = rand(255).to_s(16)

    r, g, b = [r, g, b].map { |s| if s.size == 1 then '0' + s else s end }

    color = a + r + g + b
  end


end
