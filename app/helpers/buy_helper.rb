module BuyHelper

  def buy_sell_logic
      @price = params[:price].to_i
      @buy = params[:buy].to_i
      @user_id = params[:user_id]

      if @buy == 0
        @usd_total = params[:usd_total].to_i * (-1)
        @btc_total = params[:btc_total].to_i
      else 
        @usd_total = params[:usd_total].to_i
        @btc_total = params[:btc_total].to_i * (-1)
      end

      if -@usd_total > @user.current_usd_balance
        flash[:error] = "Not enough USD in balance to complete this transaction!"
        redirect_to user_path(@user)
      end

      if -@btc_total > @user.current_btc_balance
        flash[:error] = "Can't sell Bitcoins you don't have!"
        redirect_to user_path(@user)
      end

      if -@usd_total <= 0 && @btc_total > 0
        flash[:error] = "Invalid Entry, but nice try"
        redirect_to user_path(@user)
      end

      if @usd_total <= 0 && @btc_total < 0
        flash[:error] = "Invalid Entry, but nice try"
        redirect_to user_path(@user)
      end

    end

end