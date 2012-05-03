
public class Piece {
	private String name;
	private String position;
	private String facing;
	
	public Piece(String name, String position, String facing) {
		super();
		this.name = name;
		this.position = position;
		this.facing = facing;
	}
	
	public String getName() {
		return name;
	}

	public String getPosition() {
		return position;
	}

	public String getFacing() {
		return facing;
	}
}
