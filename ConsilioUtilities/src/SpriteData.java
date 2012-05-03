
public class SpriteData {
	private String name;
	private String animationData;
	private String spriteSheet;
	private int xoffset;
	private int yoffset;
	private Attributes attributes;
	
	public SpriteData(String name, String animationData, String spriteSheet,
			int xoffset, int yoffset, Attributes attributes) {
		this.name = name;
		this.animationData = animationData;
		this.spriteSheet = spriteSheet;
		this.xoffset = xoffset;
		this.yoffset = yoffset;
		this.attributes = attributes;
	}

	public String getName() {
		return name;
	}

	public String getAnimationData() {
		return animationData;
	}

	public String getSpriteSheet() {
		return spriteSheet;
	}

	public int getXoffset() {
		return xoffset;
	}

	public int getYoffset() {
		return yoffset;
	}

	public Attributes getAttributes() {
		return attributes;
	}
	
	
}
