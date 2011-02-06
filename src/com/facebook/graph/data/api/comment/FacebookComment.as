package com.facebook.graph.data.api.comment {
    import com.adobe.utils.DateUtil;
    import com.facebook.graph.data.api.user.FacebookUser;

    /**
     * A comment.
     * @see http://developers.facebook.com/docs/reference/api/comment
     */
    public class FacebookComment {

        /**
         * Creates a new Comment.
         */
        public function FacebookComment() {
        }

        /**
         * The time comment was initially created.
         */
        public var created_time:Date;

        /**
         * An object containing the ID and name of the user who posted this comment.
         */
        public var from:FacebookUser;
        /**
         * The comment ID.
         */
        public var id:String;

        /**
         * The number of times this comment has been liked.
         */
        public var likes:int;

        /**
         * The comment message.
         */
        public var message:String;

        /**
         * Populates the album from a decoded JSON object.
         */
        public function fromJSON( result:Object ):void {
            if ( result != null ) {
                for ( var property:String in result ) {
                    switch ( property ) {
                        case "from":
                            from = new FacebookUser();
                            from.fromJSON( result[ property ]);
                            break;

                        case "created_time":
                            created_time = DateUtil.parseW3CDTF( result[ property ]);
                            break;

                        default:
                            if ( hasOwnProperty( property ))
                                this[ property ] = result[ property ];
                            break;
                    }
                }
            }
        }

        /**
         * Provides the string value of the album.
         */
        public function toString():String {
            return '[ id: ' + id + ', message: ' + message + ' ]';
        }
    }
}