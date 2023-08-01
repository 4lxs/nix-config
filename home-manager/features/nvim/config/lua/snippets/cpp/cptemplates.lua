return {
	s(
		"!cp",
		fmt(
			[[
#include <bits/stdc++.h>
using namespace std;

/* clang-format off */
template<typename A, typename B> ostream& operator<<(ostream &os, const pair<A, B> &p) {{ return os << '(' << p.first << ", " << p.second << ')'; }}
template<typename T> ostream& operator<<(ostream &os, const vector<T> &p) {{ os << "{{ "; for (auto const &i: p) os<<i<<" "; return os<<'}}'; }}
template<typename T_container, typename T = typename enable_if<!is_same<T_container, string>::value, typename T_container::value_type>::type> ostream& operator<<(ostream &os, const T_container &v) {{ os << '{{'; string sep; for (const T &x : v) os << sep << x, sep = ", "; return os << '}}'; }}
void dbg_out() {{ cerr << endl; }}
template<typename Head, typename... Tail> void dbg_out(Head H, Tail... T) {{ cerr << ' ' << H; dbg_out(T...); }}
#ifdef DEBUG
#define dbg(...) cerr << "(" << #__VA_ARGS__ << "):", dbg_out(__VA_ARGS__)
#else
#define dbg(...)
#endif
/* clang-format on */

int main() {{
  ios_base::sync_with_stdio(0);
  cin.tie(0);
  cout.tie(0);

  {}
}}
    ]],
			{ i(0) }
		)
	),
	s(
		"!cpt",
		fmt(
			[[
#include <bits/stdc++.h>
using namespace std;

/* clang-format off */
template<typename A, typename B> ostream& operator<<(ostream &os, const pair<A, B> &p) {{ return os << '(' << p.first << ", " << p.second << ')'; }}
template<typename T> ostream& operator<<(ostream &os, const vector<T> &p) {{ os << "{{ "; for (auto const &i: p) os<<i<<" "; return os<<'}}'; }}
template<typename T_container, typename T = typename enable_if<!is_same<T_container, string>::value, typename T_container::value_type>::type> ostream& operator<<(ostream &os, const T_container &v) {{ os << '{{'; string sep; for (const T &x : v) os << sep << x, sep = ", "; return os << '}}'; }}
void dbg_out() {{ cerr << endl; }}
template<typename Head, typename... Tail> void dbg_out(Head H, Tail... T) {{ cerr << ' ' << H; dbg_out(T...); }}
#ifdef DEBUG
#define dbg(...) cerr << "(" << #__VA_ARGS__ << "):", dbg_out(__VA_ARGS__)
#else
#define dbg(...)
#endif
/* clang-format on */

void solve() {{
  {}
}}

int main() {{
  ios_base::sync_with_stdio(0);
  cin.tie(0);
  cout.tie(0);

  int t;
  cin >> t;
  while (t--) solve();
}}
    ]],
			{ i(0) }
		)
	),
}
