class ValidatesCustomers < ActiveModel::Validator
  def validates_customers(record)
    return true if record.customers.empty?
    record.customers.all?(&:valid?)
  end

  def validate(record)
    unless validates_customers(record)
      record.errors.add(:base, I18n.t('errors.invalid_customers'))
    end
  end
end
