class  Admin::CashesController < Admin::AdminController

  require 'will_paginate/array'
  require 'jasper-bridge'

  include ApplicationHelper
  include Jasper::Bridge

  layout 'admin'

  before_action :set_payments, only: [:payments_pdf]
  before_action :set_expenses, only: [:expenses_pdf]
  before_action :set_overdue, only: [:overdue_pdf]

  def index
    @cashes = []

    @tuitionPeople = TuitionPerson.where.not(pay_day: nil)
    @invoces = Invoice.where.not(pay_day: nil)
    @expenses = Expense.all

    @totInput = 0.0
    @totOutput = 0.0

    @tuitionPeople.each do |t|
      @cash = Cash.new    
      @cash.id = t.id
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
      @cash.id = i.id  
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

    @cashes = @cashes.sort_by { |cash| cash.pay_day }
    @cashes = @cashes.paginate(:page => params[:page], :per_page => 20, :order => 'pay_day DESC')
  end

  def payments_pdf
    xml_data = render_to_string('payments.xml.builder', layout: false)    
    @company = Company.find( session[:current_company] )      
    @di = format_dt @init_date.to_s
    @df = format_dt @end_date.to_s
    encoded_string = Base64.encode64("DI#VLR##{@di}#RS#DF#VLR##{@df}#RS#")
    send_doc(xml_data, '/cashes/cash', 'payments.jasper', "Relatório de Pagamentos", encoded_string, "pdf")
  end

  def expenses_pdf
    xml_data = render_to_string('expenses.xml.builder', layout: false)    
    @company = Company.find( session[:current_company] )      
    @di = format_dt @init_date.to_s
    @df = format_dt @end_date.to_s
    encoded_string = Base64.encode64("DI#VLR##{@di}#RS#DF#VLR##{@df}#RS#")
    send_doc(xml_data, '/cashes/cash', 'expenses.jasper', "Relatório de Despesas", encoded_string, "pdf")
  end

  def overdue_pdf
    xml_data = render_to_string('overdue.xml.builder', layout: false)    
    @company = Company.find( session[:current_company] )      
    @di = format_dt @init_date.to_s
    @df = format_dt @end_date.to_s
    encoded_string = Base64.encode64("DI#VLR##{@di}#RS#DF#VLR##{@df}#RS#")
    send_doc(xml_data, '/cashes/cash', 'overdue.jasper', "Relatório de Inadimplentes", encoded_string, "pdf")
  end

  private 

    def set_payments
      @init_date = format_date_hour_ini_us params[:initial_date]
      @end_date  = format_date_hour_fin_us params[:final_date]

      @cashes = []
      @tuitionPeople = TuitionPerson.where.not(pay_day: nil).where(:pay_day => @init_date..@end_date)
      @invoces = Invoice.where.not(pay_day: nil).where(:pay_day => @init_date..@end_date)

      @tuitionPeople.each do |t|
        @cash = Cash.new    
        @cash.type = 'Mensalidade'
        @cash.identifier = 1
        @cash.pay_day = t.pay_day
        @cash.created_at = t.created_at
        @cash.person = t.person.name
        @cash.category = t.person.category.description
        @cash.amount = t.tuition.amount        
        @cashes.push(@cash)
      end
      
      @invoces.each do |i|
        @cash = Cash.new    
        @cash.type = i.invoice_type.description
        @cash.identifier = 1
        @cash.pay_day = i.pay_day
        @cash.created_at = i.created_at
        @cash.person = i.person.name
        @cash.category = i.person.category.description
        @cash.amount = i.amount        
        @cashes.push(@cash)
      end
            
    end

    def set_expenses 
      @init_date = format_date_hour_ini_us params[:initial_date]
      @end_date  = format_date_hour_fin_us params[:final_date]

      @cashes = []
      @expenses = Expense.expenses_between_dates(@init_date, @end_date)

      @expenses.each do |e|
        @cash = Cash.new 
        @cash.type = "Despesa"
        @cash.identifier = -1
        @cash.category = e.description
        @cash.pay_day = unless e.date_expense.nil? then e.date_expense else e.created_at end
        @cash.created_at = e.created_at
        @cash.person = e.provider
        @cash.amount = e.amount        
        @cashes.push(@cash)
      end      
    end

    def set_overdue 
      @init_date = format_date_hour_ini_us params[:initial_date]
      @end_date  = format_date_hour_fin_us DateTime.now.to_s

      @cashes = []

      @tuitionPeople = TuitionPerson.where(pay_day: nil).where(cancel_date: nil).where(:due_date => @init_date..@end_date)
      @invoices = Invoice.where(pay_day: nil).where(cancel_date: nil).where(:due_date => @init_date..@end_date)      

      @tuitionPeople.each do |t|
        @cash = Cash.new    
        @cash.type = 'Mensalidade'
        @cash.identifier = 1
        @cash.due_date = t.due_date
        @cash.created_at = t.created_at
        @cash.person = t.person.name
        @cash.category = t.person.category.description
        @cash.amount = t.tuition.amount        
        @cashes.push(@cash)
      end
      
      @invoices.each do |i|
        @cash = Cash.new    
        @cash.type = i.invoice_type.description
        @cash.identifier = 1
        @cash.due_date = i.due_date
        @cash.created_at = i.created_at
        @cash.person = i.person.name
        @cash.category = i.person.category.description
        @cash.amount = i.amount        
        @cashes.push(@cash)
      end
    end
  
end
