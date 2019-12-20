class Collection
  def initialize(csv_file_path, klass)
    @collection = create_collection(csv_file_path, klass)
  end

  def create_collection(csv_file_path, klass)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)

    csv.map do |row|
       klass.new(row)
    end
  end

  def find(collection_objects, id)
    collection_objects.find do |item|
      item.id == id
    end
  end
end
