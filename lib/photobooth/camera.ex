defmodule Photobooth.Camera do
  use GenServer

  @photos Path.join(:code.priv_dir(:photobooth), "photos")

  ##############
  ### Client ###
  ##############

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get_frame do
    GenServer.call(__MODULE__, :get_frame, 30_000)
  end

  def snap do
    GenServer.call(__MODULE__, :snap, 30_000)
  end

  ##############
  ### Server ###
  ##############

  def init(nil) do
    File.mkdir_p!(@photos)
    {:ok, start_camera()}
  end

  def handle_call(:get_frame, _from, camera) do
    {:reply, Picam.next_frame, camera}
  end

  def handle_call(:snap, _from, camera) do
    stop_camera(camera)

    file =
      NaiveDateTime.utc_now
      |> to_string()
      |> String.replace(~r{\..+\z}, "")
      |> String.replace(":", "-")
      |> String.replace(" ", "_")
      |> Kernel.<>(".jpg")
    photo = Path.join(@photos, file)

    {"", 0} = System.cmd("raspistill", ~w[-n -q 100 -rot 270 -hf -o #{photo}])

    {:reply, :ok, start_camera()}
  end

  ###############
  ### Helpers ###
  ###############

  defp start_camera do
    {:ok, camera} = Picam.Camera.start_link
    Picam.set_size(320, 240)
    Picam.set_rotation(270)
    Picam.set_hflip(true)
    camera
  end

  defp stop_camera(camera) do
    :sys.get_state(camera)
    |> Map.fetch!(:port)
    |> Port.close
    GenServer.stop(camera)
  end
end
