module KnowtifyApiResponses
  def successful_response
    standard_response.to_json
  end

  def no_contact_response
    resp = standard_response
    resp[:contacts] = 0
    resp[:contacts_updated] = 0
    resp[:warnings] = [
      "No contacts? You might have a formatting error. 'contacts' should be an array[] of objects{}."
    ]
    resp.to_json
  end

  def error_response
    resp = standard_response
    resp[:contacts_updated] = 0
    resp[:contacts_errored] = 1
    resp.to_json
  end

  private

  def standard_response
    {
      status: "received",
      contacts: 1,
      contacts_updated: 1,
      contacts_errored: 0,
      errors: "None found by our cylon detector.",
      warnings: "...and zero warnings! Your request is in ship shape!"
    }
  end
end
