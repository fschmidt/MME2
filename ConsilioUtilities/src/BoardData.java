import java.util.ArrayList;
import java.util.List;


public class BoardData {
	
	private List<Piece> pieces = new ArrayList<Piece>();

	public void addPiece(String name, String position, String facing) {
		pieces.add(new Piece(name, position, facing));
	}

}
