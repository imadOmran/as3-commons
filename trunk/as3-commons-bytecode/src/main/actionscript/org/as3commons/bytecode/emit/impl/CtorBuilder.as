/*
 * Copyright 2007-2010 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.as3commons.bytecode.emit.impl {
	import org.as3commons.bytecode.abc.LNamespace;
	import org.as3commons.bytecode.abc.MethodInfo;
	import org.as3commons.bytecode.abc.MethodTrait;
	import org.as3commons.bytecode.abc.QualifiedName;
	import org.as3commons.bytecode.abc.TraitInfo;
	import org.as3commons.bytecode.abc.enum.BuiltIns;
	import org.as3commons.bytecode.abc.enum.NamespaceKind;
	import org.as3commons.bytecode.abc.enum.TraitKind;
	import org.as3commons.bytecode.emit.ICtorBuilder;
	import org.as3commons.bytecode.emit.enum.MemberVisibility;
	import org.as3commons.bytecode.util.AbcDeserializer;
	import org.as3commons.bytecode.util.MultinameUtil;
	import org.as3commons.lang.Assert;

	public class CtorBuilder extends MethodBuilder implements ICtorBuilder {

		public static const STATIC_CONSTRUCTOR_NAME_SUFFIX:String = '$cinit';

		public function CtorBuilder() {
			super("", MemberVisibility.PUBLIC);
			returnType = BuiltIns.ANY.fullName;
		}

		override public function build(initScopeDepth:uint = 1):Array {
			var result:Array = super.build(initScopeDepth);
			var mi:MethodInfo = MethodInfo(result[0]);
			mi.returnType = MultinameUtil.toQualifiedName(returnType, NamespaceKind.NAMESPACE);
			mi.as3commonsBytecodeName = AbcDeserializer.CONSTRUCTOR_BYTECODENAME;
			return result;
		}

		override protected function buildTrait():TraitInfo {
			var trait:MethodTrait = new MethodTrait();
			trait.traitKind = TraitKind.METHOD;
			trait.isFinal = isFinal;
			trait.isOverride = false;
			trait.traitMultiname = new QualifiedName(LNamespace.ASTERISK.name, LNamespace.ASTERISK);
			return trait;
		}

	}
}