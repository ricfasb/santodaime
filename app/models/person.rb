class Person < ActiveRecord::Base

  has_attached_file :photo, styles: { thumb: "110x110>" }, default_url: "/assets/foto_pessoa-2052e00ecae3107cda8ff0b8b8d1fae4ef457df77a49808cab192d6d3f5a88b7.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  belongs_to :category  
  has_one :marital_state
  has_one :degree_education

  has_one :address,           as: :addressable,   :dependent => :destroy
  has_one :driver_license,    as: :licensable,    :dependent => :destroy
  has_one :occupation,        as: :occupatiable,  :dependent => :destroy
  has_one :deficiency_person, as: :deficiencable, :dependent => :destroy
  
  validates_presence_of :name, :category
  #, :email, :date_born 
  #validates :email, format: { with: Devise.email_regexp, message: "inválido" }
  validates_uniqueness_of :cpf, :allow_blank => true, :allow_nil => true
  validates_uniqueness_of :email, :allow_blank => true, :allow_nil => true  

  validates_length_of :cpf, :maximum => 11
  before_validation :unmask_cpf
  accepts_nested_attributes_for :address,           :allow_destroy => true  
  accepts_nested_attributes_for :occupation,        :allow_destroy => true
  accepts_nested_attributes_for :driver_license,    :allow_destroy => true
  accepts_nested_attributes_for :deficiency_person, :allow_destroy => true

  def unmask_cpf    
    self.cpf.gsub!(/(\.|\-)/, "")    
    self.telephone_residence.gsub!(/(\(|\)|\-|\ )/, "")    
    self.smartphone_number.gsub!(/(\(|\)|\-|\ )/, "")
    self.telephone_message.gsub!(/(\(|\)|\-|\ )/, "")
    #self.cep.gsub!(/(\-)/, "")
  end
end
