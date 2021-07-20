class BaseRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @elements = []
    @next_id = 1
    # load_csv if File.exist?(@csv_file_path)
  end

  def all
    @elements
  end

  def create(element) # instance
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end
end
