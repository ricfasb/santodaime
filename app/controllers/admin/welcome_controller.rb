class Admin::WelcomeController < Admin::AdminController

  layout "admin"

  def index
    @people = Person.where("LENGTH(fingerprint) > 0")  
    @peopleWithoutFingerprint = Person.where("LENGTH(fingerprint) = 0") 
    @people_has_birthday_this_month = Person.where('date_born IS NOT NULL and EXTRACT(month FROM date_born) = ?', Time.now.month)      
  end
  
end