#!/bin/bash
set -e

echo 'Installing - customize-cra react-app-rewired @types/styled-jsx'
npm i customize-cra react-app-rewired @types/styled-jsx --save-dev

cat << EOF > config-overrides.js
/* eslint-disable react-hooks/rules-of-hooks */
const { addBabelPlugins, override } = require("customize-cra");
module.exports = override(
  ...addBabelPlugins(
    "styled-jsx/babel"
    /* Add plug-in names here (separate each value by a comma) */
  )
);
EOF
echo '+ config-overrides.js'

mkdir -p src/types

cat << EOF > src/types/styled-jsx.d.ts
/* eslint-disable */
import 'react';

declare module 'react' {
  interface StyleHTMLAttributes<T> extends React.HTMLAttributes<T> {
    jsx?: boolean;
    global?: boolean;
    children?: any;
  }
}
EOF
echo '+ src/types/styled-jsx.d.ts'


cat << EOF

# package.json
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ...
  "scripts": {
    "start": "react-app-rewired start",
    "build": "react-app-rewired build",
    "test": "react-app-rewired test"
  },
  ...
++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# tsconfig.json
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{
  "compilerOptions": {
    ....
    "typeRoots": [
      "node_modules/@types",
      "src/types"
    ]
  },
  ....
++++++++++++++++++++++++++++++++++++++++++++++++++++++++

EOF