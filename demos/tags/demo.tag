<riot-form-input-text>
	<input type="text"
		onchange={onvaluechange}
		value={opts.value||""} name={opts.name}
		/>
	<script>
		this.onvaluechange = function(e){
			var val = e.target.value;
			opts.onvaluechange && opts.onvaluechange(val)
		}
	</script>
</riot-form-input-text>
<riot-form-input-bool>
	<input
		onchange={onvaluechange}
		type="checkbox"
		checked={opts.value} name={schema.name}
		/>
	<span> {schema.displayName || schema.name || ""} </span>

	<script>
		this.schema = opts.schema
		this.onvaluechange = function(e){
			var val = !!e.target.checked;
			console.log("bool change", opts.onvaluechange)
			opts.onvaluechange && opts.onvaluechange(val)
			e.preventUpdate = true;
		}
	</script>
</riot-form-input-bool>
<riot-form-input>
	<label>
		<span class="label" if={opts.schema.type!="Bool"}>
			{opts.schema.displayName || opts.schema.name}
		</span>
		<div name="inputBody"></div>
	</label>
	<script>
		var riot = require("riot")
		var tagHash = {
			Bool: "riot-form-input-bool",
			Text: "riot-form-input-text"
		}
		var defaults = require("lodash/defaults")
		defaults(opts, { schema: {} });
		var {name, defaultValue, type} = opts.schema;

		var tag = tagHash[type];
		if(tag){
			riot.mount(this.inputBody, tag, {
				schema: opts.schema,
				value:opts.value,
				onvaluechange:(val)=>{
					console.log("mounted input change", val)
				}
			})
		}else {
			throw Error(`[riot-form] type ${type} is not supported`)
		}
	</script>
	<style type="autoprefixer" scoped>
		:scope { margin:5px 0; font-size:14px; display:block; line-height: 1.4em;
			font-family: helvetica, arial;
			& > label > .label { font-weight: bold; margin-bottom: 4px; display:block; }
		}
		input { font-size:14px; line-height: 1.4em;
			border-radius:4px; padding:6px 10px; border:1px solid rgba(0,0,0,.2); }
		input[type=checkbox] {padding:0; margin:0 5px 0 0;}
		[name=inputBody]{ display: flex; align-items: center; margin-bottom: 5px;}
	</style>
</riot-form-input>
<riot-form>
	<form>
		<riot-form-input
			schema={row}
			onvaluechange={onvaluechange(row.name)}
			each={row in opts.schema}
			></riot-form-input>
	</form>
	<script>
		this.data = opts.data || {};
		// this.onvaluechange =
		this.onvaluechange = (key)=> (val)=>{
			console.log("form change args",val)
			this.data[key] = val;
			console.log("form change", this.data)
		}
			// opts.onvaluechange && opts.onvaluechange(this.data);
		// this.onvaluechange = (key)=> (val)=>
		// 	this.data[key] = val;
		// 	opts.onvaluechange && opts.onvaluechange(this.data);
	</script>
</riot-form>
<demo>
	<riot-form onvaluechange={onvaluechange} schema={sampleSchema}></riot-form>
	<p>Demo</p>
	<script>
		// this.onvaluechange = (e, data)=>{
		// 	console.log("changed data", e, data)
		// }
		this.sampleSchema = [
			{type:"Bool", name:"bool", displayName:"BoolTest"},
			{type:"Text", name:"text", displayName:"TextTest"},
		]
	</script>
</demo>
