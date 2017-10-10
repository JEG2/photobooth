defmodule Photobooth.Camera do
  use GenServer

  ##############
  ### Client ###
  ##############

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get_frame do
    GenServer.call(__MODULE__, :get_frame)
  end

  def snap do
    GenServer.call(__MODULE__, :snap)
  end

  ##############
  ### Server ###
  ##############

  def init(nil) do
    Picam.set_img_effect(:none)
    Picam.set_size(640, 480)
    Picam.set_rotation(270)
    Picam.set_hflip(true)

    {:ok, nil}
  end

  def handle_call(:get_frame, _from, nil) do
    {:reply, Picam.next_frame, nil}
  end

  def handle_call(:snap, _from, nil) do
    photos = Path.join(:code.priv_dir(:photobooth), "photos")
    File.mkdir_p!(photos)

    file =
      NaiveDateTime.utc_now
      |> to_string()
      |> String.replace(~r{\..+\z}, "")
      |> String.replace(":", "-")
      |> String.replace(" ", "_")
      |> Kernel.<>(".jpg")
    photo = Path.join(photos, file)

    Picam.set_size(3280, 2464)
    File.write!(photo, Picam.next_frame)
    Picam.set_size(640, 480)

    {:reply, :ok, nil}
  end
end
