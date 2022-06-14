class ValidatesPanels < ActiveModel::Validator
  def validates_panels(record)
    return true if record.panels.blank? # allow blank
    JSON.parse(record.panels).all? do |item|
      !item.blank? && \
      !item['panelId'].blank? && \
      PANEL_TYPES.keys.map(&:to_s).include?(item['panelType'].downcase)
    end
  end

  def validate(record)
    unless validates_panels(record)
      record.errors.add(:base, I18n.t('errors.invalid_panels'))
    end
  end
end
