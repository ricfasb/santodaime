class  Admin::CashController <  Admin::AdminController

  layout 'admin'

  def index
    @cashes = []

    @tuitionPeople = TuitionPerson.all
    @invoces = Invoice.all

    @totInput = 0.0

    @tuitionPeople.each do |t|
      @cash = Cash.new    
      @cash.type = 'Mensalidade'
      @cash.person = t.person.name
      @cash.amount = t.tuition.amount
      @totInput = @totInput + t.tuition.amount
      @cashes.push(@cash)
    end
    
    @invoces.each do |i|
      @cash = Cash.new    
      @cash.type = i.invoice_type.description
      @cash.person = i.person.name
      @cash.amount = i.amount
      @totInput = @totInput + i.amount
      @cashes.push(@cash)
    end
    
  end
  
end
