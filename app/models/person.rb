class Person < ActiveRecord::Base

  #has_attached_file :photo, styles: { thumb: "110x110>" }, default_url: "/assets/foto_pessoa-2052e00ecae3107cda8ff0b8b8d1fae4ef457df77a49808cab192d6d3f5a88b7.png"
  #validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  belongs_to :category  
  belongs_to :marital_state, optional: true
  belongs_to :degree_education, optional: true

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

  after_create :generate_tuitions
  
  has_many :tuition_person, :dependent => :destroy  

  def uploaded_file=(incoming_file)
    self.filename = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    self.photo_file = incoming_file.read
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end

  def self.people_has_no_checkin(date_ini, date_fin)
    where("not exists (SELECT 1 FROM checkins WHERE people.id = checkins.person_id AND checkins.created_at BETWEEN ? AND ?)", date_ini, date_fin)    
  end

  #gera as mensalidades 
  def generate_tuitions
    @year = Time.now.year
    @actual_month = Time.now.month
    self.category.category_tuitions.each do |c|
      for month in @actual_month..12
        @tuition_person = TuitionPerson.new
        @tuition_person.person_id = self.id
        @tuition_person.tuition_id = c.tuition.id
        datestr = "#{c.tuition.day}-#{month}-#{@year}"      
        @tuition_person.due_date = Date.parse(datestr)
        @tuition_person.status_payment = "pending"
        @tuition_person.save
      end
    end
  end

  private
    def unmask_cpf    
      self.cpf.gsub!(/(\.|\-)/, "")    
      self.telephone_residence.gsub!(/(\(|\)|\-|\ )/, "")    
      self.smartphone_number.gsub!(/(\(|\)|\-|\ )/, "")
      self.telephone_message.gsub!(/(\(|\)|\-|\ )/, "")
      #self.cep.gsub!(/(\-)/, "")
    end

    def sanitize_filename(filename)
      #get only the filename, not the whole path (from IE)
      just_filename = File.basename(filename)
      #replace all non-alphanumeric, underscore or periods with underscores
      just_filename.gsub(/[^\w\.\-]/, '_')
    end

end
