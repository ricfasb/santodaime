class  Admin::CashController <  Admin::AdminController

  require 'will_paginate/array'
  
  layout 'admin'

  def index
    @cashes = []

    @tuitionPeople = TuitionPerson.where.not(pay_day: nil)
    @invoces = Invoice.where.not(pay_day: nil)
    @expenses = Expense.all

    @totInput = 0.0
    @totOutput = 0.0

    @tuitionPeople.each do |t|
      @cash = Cash.new    
      @cash.type = 'Mensalidade'
      @cash.identifier = 1
      @cash.pay_day = t.pay_day
      @cash.created_at = t.created_at
      @cash.person = t.person.name
      @cash.amount = t.tuition.amount
      @totInput = @totInput + t.tuition.amount
      @cashes.push(@cash)
    end
    
    @invoces.each do |i|
      @cash = Cash.new    
      @cash.type = i.invoice_type.description
      @cash.identifier = 1
      @cash.pay_day = i.pay_day
      @cash.created_at = i.created_at
      @cash.person = i.person.name
      @cash.amount = i.amount
      @totInput = @totInput + i.amount
      @cashes.push(@cash)
    end

    @expenses.each do |e|
      @cash = Cash.new 
      @cash.type = "Despesa"
      @cash.identifier = -1
      @cash.pay_day = e.created_at
      @cash.created_at = e.created_at
      @cash.person = e.provider
      @cash.amount = e.amount
      @totOutput = @totOutput + e.amount
      @cashes.push(@cash)
    end

    @cashes = @cashes.paginate(:page => params[:page], :per_page => 20, :order => 'pay_day DESC')
  end
  
end
