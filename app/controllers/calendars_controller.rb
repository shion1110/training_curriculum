class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
   
  end

  # 予定の保存
  def create
  
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date,:plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end


      require "date"


day = Date.today.wday + x
# # 1 x = 0
# day = Date.today.wday + 0 (day = 1)
# # 2 x = 1
# day = Date.today.wday + 1 (day = 2)
# # 3 x = 2
# day = Date.today.wday + 2 (day = 3)
# # 4 x = 3
# day = Date.today.wday + 3 (day = 4)
# day = Date.today.wday + 4 (day = 5)
# day = Date.today.wday + 5 (day = 6)
# ===========
# day = Date.today.wday + 6 - 7 (day = 7)

if   day >= 7 #dayが7以上になったら
   day = day - 7
end
     

      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, days: (wdays[day]), plans: today_plans}

      @week_days.push(days)
    end

  end
end

