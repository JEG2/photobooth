defmodule Photobooth.Uploader do
  use GenServer
  require Logger
  alias ExAws.S3

  ##############
  ### Client ###
  ##############

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def upload(path) do
    GenServer.cast(__MODULE__, {:upload, path})
  end

  ##############
  ### Server ###
  ##############

  def init(nil) do
    send(self(), :create_bucket)
    {:ok, nil}
  end

  def handle_cast({:upload, path}, bucket) do
    file = Path.basename(path)

    S3.put_object(bucket, file, File.read!(path))
    |> ExAws.request!
    File.rm(path)

    {:noreply, bucket}
  end

  def handle_info(:create_bucket, nil) do
    bucket = System.get_env("AWS_BUCKET")
    if is_nil(bucket) do
      raise "AWS_BUCKET must be set."
    end

    S3.put_bucket(bucket, "us-west-2")
    |> ExAws.request!

    {:noreply, bucket}
  end
  def handle_info(message, bucket) do
    Logger.debug "Unexpected message:  #{inspect message}"
    {:noreply, bucket}
  end
end
