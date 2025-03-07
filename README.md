# Tutorial 4 - Game Development

## Latihan Mandiri: Membuat Level Baru Dengan Tile Map & Obstacle Berbeda

-   Nama: Adnan Mukhtar
-   NPM: 2006485245

## Proses Pengerjaan

### 1. Membuat Scene Baru

-   Buat scene baru dengan menggunakan Node2D.
-   Ubah namanya menjadi Level2.

### 2. Membuat Karakter/Player

-   Buat Player dengan menggunakan CharacterBody2D sebagai child node.
-   Tambahkan Sprite sebagai child node dan ubah texture dengan gambar player yang diinginkan.
-   Tambahkan juga CollisionShape2D.

### 3. Membuat Tilemap

-   Buat Tilemap dengan menggunakan TileMapLayer seperti pada Tutorial.
-   Setelah itu pilih Tileset pada menu bagian bawah dan pilih asset gambar yang ingin digunakan.
-   Untuk memulai menggambar dengan tileset yang baru, pilih kembali menu TileMap pada menu di bawah.
-   Lalu pilih tool Paint(D) pada toolbar TileMap, kemudian pilih salah satu tile Anda. Ketika sudah dipilih, mulai menggambar desain sesuai yang diinginkan pada scene dengan menekan tombol kiri mouse, dan tombol kanan mouse untuk menghapus dan tambahkan kolisi disetiap tile yang akan digunakan.

### 4. Implementasi Jurang dengan Signal

-   Buat scene baru dengan nama AreaTrigger menggunakan node Area2D.
-   Tambahkan script pada node tersebut dan hapus semua baris pada script baru tersebut kecuali statement extends.
-   Lalu pilih node Area2D lalu buka tab Node, pada subtab Signals pilih body_entered() dan klik tombol Connect di kanan bawah tab tersebut.
-   Pastikan Area2D terpilih pada bagian Connect To Node, isi Method In Node dengan nama fungsi yang diinginkan atau biarkan default. Jika sudah tekan tombol Connect. Setelah itu, script pada Area2D akan ditambah fungsi tersebut.
-   Kemudian tambahkan script dengan nama AreaTrigger.gd pada fungsi tersebut:

    ```python
    extends Area2D

    @export var sceneName: String = "Level1"

    func _on_Area_Trigger_body_entered(body: Node2D) -> void:
      if body.name == "Player":
    	    get_tree().call_deferred("change_scene_to_file", str("res://    scenes/" + sceneName + ".tscn"))
    ```

-   Sesuaikan nama fungsi dengan yang sudah dibuat.
-   Kemudian tambahkan scene AreaTrigger yang sudah dibuat kedalam scene level yang sedang dibuat. Atur posisi scene tersebut seolah menjadi jurang. Atur juga variabel sceneName menjadi nama scene yang akan ditampilkan ketika pemain terjatuh, misalnya LoseScreen

### 5. Implementasi Rintangan dengan Spawner

-   Buat scene baru dengan root node RigidBody2D disini saya membuat dengan nama FallingFire.
-   Tambahkan Sprite dan CollisionShape2D sebagai child node. Atur texture pada sprite sesuai yang diinginkan dan atur bentuk CollisionShape2D.
-   Buat script yang digunakan untuk menandakan jika terkena objek tersebut maka akan kalah atau gunakan script AreaTrigger.gd yang sudah dibuat sebelumnya.
-   Selanjutnya tambahkan Node2D di dalam scene Level2 sebagai child node dengan nama Spawner.
-   Kemudian, atur posisi objek spawner di dalam dunia Level2 agar berada di langit-langit, seperti di titik koordinat (820, -645).
-   Setelah itu, buat script dengan nama Spawner.gd yang berisi:

    ```python
    extends Node2D

    @export var obstacle: PackedScene

    func _ready():
        repeat()

    func spawn():
        var spawned = obstacle.instantiate()

        get_parent().call_deferred("add_child", spawned)

        var spawn_pos = global_position
        spawn_pos.x = spawn_pos.x + randf_range(-1000, 3300)
        spawned.global_position = spawn_pos

    func repeat():
        spawn()
        await get_tree().create_timer(1).timeout
        repeat()
    ```

-   Kemudian ubah obstacle yang berada di inspector node Spawner dengan scene FallingFire.

### 6. Fitur Tambahan

-   Tutorial ini saya membuat sebuah node bernama MovingPlatform menggunakan CharacterBody2D, node ini hanya untuk membuat level menjadi bervariasi dengan adanya sebuah objek yang bergerak.
-   Setelah itu, buat script dengan nama MovingPlatform.gd yang berisi:

    ```python
    extends CharacterBody2D

    @export var start_pos: Vector2
    @export var end_pos: Vector2
    @export var speed: float = 7000.0

    var direction: int = 1

    func _physics_process(delta):
      var target: Vector2
      if direction == 1:
    	    target = end_pos
      else:
    	    target = start_pos
      var movement = (target - global_position).normalized() * speed * delta
      velocity = movement
      move_and_slide()

      if global_position.distance_to(target) < 5:
    	    direction *= -1
    ```

-   Selanjutnya, pada inspector isi variabel start_pos dan end_pos sesuai dengan posisi yang diinginkan.
