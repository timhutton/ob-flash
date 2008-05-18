package obClasses
{

/** Specifies the atom types and states that are involved in a reaction. */
public class Reaction
{
	// (just two-way for now)

	public function Reaction(a_type:int,a_pre_state:int,pre_bond:Boolean,
		b_type:int,b_pre_state:int,
		a_post_state:int,post_bond:Boolean,b_post_state:int)
	{
		this.a_type = a_type;
		this.b_type = b_type;
		this.a_pre_state = a_pre_state;
		this.b_pre_state = b_pre_state;
		this.a_post_state = a_post_state;
		this.b_post_state = b_post_state;
		this.pre_bond = pre_bond;
		this.post_bond = post_bond;
	}

	public var a_type:int;
	public var b_type:int;
	public var a_pre_state:int;
	public var b_pre_state:int;
	public var a_post_state:int;
	public var b_post_state:int;
	public var pre_bond:Boolean;
	public var post_bond:Boolean;
}

}
