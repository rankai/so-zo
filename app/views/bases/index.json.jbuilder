json.array!(@bases) do |basis|
  json.extract! basis, :id, :title, :detail
  json.url basis_url(basis, format: :json)
end
