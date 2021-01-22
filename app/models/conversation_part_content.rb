# frozen_string_literal: true

class ConversationPartContent < ApplicationRecord
  # belongs_to :conversation_part

  def as_json(*)
    super.except('created_at',
                 'updated_at',
                 'id',
                 'conversation_part_id').tap do |hash|
    end
  end

  def parsed_content
    JSON.parse(self.serialized_content)
  end

  def text_from_serialized
    begin
    parsed_content["blocks"].map{|o| o["text"]}.join(" ")
    rescue 
      html_content
    end
  end
end
