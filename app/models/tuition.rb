class Tuition < ApplicationRecord
  belongs_to :email

  validates_presence_of :description

  validates :day, presence: true
  validate :min_amount
  validate :send_mail

  def send_mail
      if send_email && email_id.nil?
          errors.add('Enviar email ativado: ', 'Necessário selecionar o email!')
      end
  end

  #valor minumo da mensalidade
  def min_amount
    if amount.nil? || amount < 5
      errors.add(:amount, 'Insira um valor maior que 5')
    end
  end

end
