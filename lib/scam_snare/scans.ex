defmodule ScamSnare.Scans do
  @moduledoc """
  The Scans context.
  """

  import Ecto.Query, warn: false
  alias ScamSnare.Repo

  alias ScamSnare.Scans.ScanRequest

  @doc """
  Returns the list of scan_requests.

  ## Examples

      iex> list_scan_requests()
      [%ScanRequest{}, ...]

  """
  def list_scan_requests do
    Repo.all(ScanRequest)
  end

  @doc """
  Gets a single scan_request.

  Raises `Ecto.NoResultsError` if the Scan request does not exist.

  ## Examples

      iex> get_scan_request!(123)
      %ScanRequest{}

      iex> get_scan_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scan_request!(id), do: Repo.get!(ScanRequest, id)

  @doc """
  Creates a scan_request.

  ## Examples

      iex> create_scan_request(%{field: value})
      {:ok, %ScanRequest{}}

      iex> create_scan_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scan_request(attrs \\ %{}) do
    %ScanRequest{}
    |> ScanRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scan_request.

  ## Examples

      iex> update_scan_request(scan_request, %{field: new_value})
      {:ok, %ScanRequest{}}

      iex> update_scan_request(scan_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scan_request(%ScanRequest{} = scan_request, attrs) do
    scan_request
    |> ScanRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a scan_request.

  ## Examples

      iex> delete_scan_request(scan_request)
      {:ok, %ScanRequest{}}

      iex> delete_scan_request(scan_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scan_request(%ScanRequest{} = scan_request) do
    Repo.delete(scan_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scan_request changes.

  ## Examples

      iex> change_scan_request(scan_request)
      %Ecto.Changeset{data: %ScanRequest{}}

  """
  def change_scan_request(%ScanRequest{} = scan_request, attrs \\ %{}) do
    ScanRequest.changeset(scan_request, attrs)
  end
end
