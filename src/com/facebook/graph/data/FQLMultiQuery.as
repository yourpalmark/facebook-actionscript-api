/*
	Copyright (c) 2010, Adobe Systems Incorporated
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are
	met:
	
	* Redistributions of source code must retain the above copyright notice,
	this list of conditions and the following disclaimer.
	
	* Redistributions in binary form must reproduce the above copyright
	notice, this list of conditions and the following disclaimer in the
	documentation and/or other materials provided with the distribution.
	
	* Neither the name of Adobe Systems Incorporated nor the names of its
	contributors may be used to endorse or promote products derived from
	this software without specific prior written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
	IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
	THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
	PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
	CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
	EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
	PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
	PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
	LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
	NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package com.facebook.graph.data {
	import com.adobe.serialization.json.JSON;
	
	/**
	 * VO to hold multiple queries for use in Facebook.fqlMultiQuery
	 *
	 */
	public class FQLMultiQuery {
		
		/**
		 * Hash of query strings, indexed by query name 
		 */		
		public var queries:Object;
		
		/**
		 * Creates a new FQLMultiQuery.
		 *
		 */
		public function FQLMultiQuery() {
			queries = {};
		}
		
		/**
		 * Adds a new query. Throws an error if there are duplicate query names
		 *  
		 * @param query String The query string to execute
		 * @param name String The name of the query
		 * @param values Object Replaces string values in the in the query. 
		 * ie. Replaces {digit} or {id} with the corresponding key-value in the object
		 * 
		 */		
		public function add(query:String, name:String, values:Object = null):void {			
			if (queries.hasOwnProperty(name)) { throw new Error("Query name already exists, there cannot be duplicate names"); }
			
			for (var n:String in values) {
				query = query.replace(new RegExp('\\{'+n+'\\}', 'g'), values[n]);
			}
			
			queries[name] = query;
		}
		
		/**
		 * 
		 * @return String The JSON encoded value of the queries object
		 * 
		 */		
		public function toString():String {
			return JSON.encode(queries);			
		}
	}
}