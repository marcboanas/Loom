module ApplicationHelper
    
    # Returns the full title on a per-page basis.
    def full_title(page_title)
        base_title = "Account Hero"
        if page_title.empty?
            base_title
            else
            "#{base_title} | #{page_title}"
        end
    end
    
    def currency(amount)
        number_to_currency(amount, unit: "&pound;", separator: ".", delimiter: ",")
    end
end
