# Git introduction ½ day course

Welcome to the Git Introduction ½ day course for Equinor ASA.  This
entire course is available under the _**Creative Commons** Attribution Share
Alike 4.0 International license_ (cc-by-4.0).

>**You are free to:**
>
>* **Share** — copy and redistribute the material in any medium or
>  format
>* **Adapt** — remix, transform, and build upon the material for any
>  purpose, even commercially.
>
>This license is acceptable for Free Cultural Works.
>
>The licensor cannot revoke these freedoms as long as you follow the
>license terms.
>
>**Under the following terms:**
>
>* **Attribution** — You must give appropriate credit, provide a link to
>  the license, and indicate if changes were made. You may do so in any
>  reasonable manner, but not in any way that suggests the licensor
>  endorses you or your use.
>* **No additional restrictions** — You may not apply legal terms or
>  technological measures that legally restrict others from doing
>  anything the license permits.
>
>**Notices:**
>
> You do not have to comply with the license for elements of the
> material in the public domain or where your use is permitted by an
> applicable exception or limitation.
>
> No warranties are given. The license may not give you all of the
> permissions necessary for your intended use. For example, other rights
> such as publicity, privacy, or moral rights may limit how you use the
> material.




## About this course

There is nothing this course will teach you that you couldn't get from reading
the amazing [Pro Git book](https://git-scm.com/book/en/v2).  In the cases where
we will not be able to explain a topic any better than the book, which happens
to be most topics, we will put a link to the chapter and verse in the book at
the beginning of the section.

Most sections have a _reference_ section for further reading, e.g.

> **References**
>
> 1. [git-scm](https://git-scm.com/book/en/v2)
> 1. [`man gittutorial`](https://git-scm.com/docs/gittutorial)
> 1. [Learn Git branching](https://learngitbranching.js.org/)

It is recommended that you take some time to read through the material.

Note that this course will be completely console/text based, and the goal is
that if you understand the foundation of git and version control, you will also
be able to use Git through graphical user interfaces, such as
[`gitk`](https://git-scm.com/docs/gitk) that might already be available on your
system.


**A half day course**

The topics for a four hour course is:

1. First commits and browsing
2. Linear use and undoing
3. Branches
4. Remotes


The least interesting topic for a _fundamentals course_ is the topic of
_Remotes_, so when squeezed into _three hours_, we cap the that section.


The topics for a three hour course is:

1. First commits and browsing
2. Linear use and undoing
3. Branches and remotes


## Table of contents


1. [Warming up](#warming-up)
1. [The empty repository](#the-empty-repository)
1. [Your first commit](#your-first-commit)
1. [Browsing our history](#browsing-our-history)
1. [Linear use of git](#linear-use-of-git)
1. [Undoing changes](#undoing-changes)
1. [Branches in git](#branches-in-git)
1. [Remotes](#remotes)
1. [Git commands](#git-commands)

# Warming up

Open an empty pure text file.

```bash
$ nano a.txt
```

_(Note that if you are on Windows, you may use `notepad a.txt` instead.)_


Let us create some content in our file `a.txt`:

```
Mr. Utterson the lawyer was
a man of a rugged countenance
that was never lighted by a smile;
cold, scanty and embarrassed in discourse;
backward in sentiment;
lean, long, dusty, dreary
and yet somehow lovable.
```

Now, let us create a file `b.txt` which contains some errors on line five:

```
Mr. Utterson the lawyer was
a man of a rugged countenance
that was never lighted by a smile;
cold, scanty and embarrassed in discourse;
bckwrd n sntmnt;
lean, long, dusty, dreary
and yet somehow lovable.
```

If we run `diff a.txt b.txt` in the terminal, we will get the following output
(this is important)

```patch
5c5
< backward in sentiment;
---
> bckwrd n sntmnt;
```

There are four lines in this output, and each line is important.
1. `5c5` consists of two line numbers `5` and `5`, separated by a `c` (for _change_)
1. The `<` character means content in the _first_ file (`a.txt`)
1. The `---` separator means that we are done with the _first file_ of this _hunk_
1. The `>` character means content in the _second_ file (`b.txt`)

If we go back to file `b.txt` and _delete_ the fifth line (the one reading
`bckwrd n sntmnt;`), then `diff a.txt b.txt` will say

```patch
5d4
< backward in sentiment;
```

You might have guessed it: the `d` in `5d4` means that a line was _deleted_.
Were we to _add_ a line to the second file, the output would likely be `5a6`.

Notice how a diff (a _patch_) between two files can tell us how to go from _one
file_ (`a.txt`) to another file (`b.txt`), and back again.  And indeed, there is
a tool, called `patch`, that takes a diff and _applies_ it to a file, producing
the second file:

```bash
$ diff a.txt b.txt > fix.patch
$ patch a.txt fix.patch
patching file a
```

It is also possible to go back

```bash
$ patch b.txt fix.patch
patching file b
Reversed (or previously applied) patch detected!  Assume -R? [n]
```

(press `y` for reverse patching).

Once you understand this back-and-forth you will be able to understand
everything version control is about!

**Hunks**

As we saw above, the diff output consisted of one line with something like
`5c5`, one (or more) line(s) starting with `<`, a separator `---`, followed by
one (or more) line(s) starting with `>`.  This is one _section_ of a diff,
called a _hunk_.  If you have several changes in different places in the file,
you will likely have _several hunks_.  You should be able to decode their
meaning now, i.e. what is the difference between `a.txt` and `b.txt`.

```patch
2c2
< a man of a rugged countenance
---
> a man of rugged countenance
6c6
< lean, long, dusty, dreary
---
> lean, long dusty, dreary
```

## Exercises

1. Create (`touch`) a new text file.
1. Write some lines.
1. Copy that file to a different file and make a couple of changes.
1. Run `diff` on the two files and save the output to a new file.
1. Experiment with several changes and inspect the output of `diff`.
1. Apply `patch` on the file and the output.

## References

* [Text files](https://en.wikipedia.org/wiki/Text_file)
* [`diff`](https://en.wikipedia.org/wiki/Diff)
* [`man diff`](http://man7.org/linux/man-pages/man1/diff.1.html)
* [`man patch`](http://man7.org/linux/man-pages/man1/patch.1.html)
* [Hunks](http://www.gnu.org/software/diffutils/manual/html_node/Hunks.html)

# The empty repository

_(NB:  You probably want to create a new folder to experiment in with `mkdir git` and `cd git` prior to `git init`.)_


We now understand the fundamentals behind revisions of files, so we are ready to
start using `git`.  Go into a new empty folder and simply write


```bash
git init
```

The output will be
```
Initialized empty Git repository in /Your/username/path/.git/
```

**Congratulations**, you have started using `git`!

To see what we have in our folder, we run

```bash
git status
```

which outputs

```
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
```

Git here tells us that we have no history, and thus no files.  So in the next
section, we will take our file `a.txt` and _add_ it to git.


_Observe_ now that though, that everything in Git is stored in the `.git`
folder, and you can always investigate its content by running `tree` (or `find
.git` if your system does not have `tree`).
On Windows, you can run `cmd //c tree .git` to use Windows' `tree` command.

```bash
$ tree .git
.git
├── branches
├── config
├── description
├── HEAD
├── hooks
│   ├── applypatch-msg.sample
│   ├── […]
│   └── update.sample
├── info
│   └── exclude
├── objects
│   ├── info
│   └── pack
└── refs
    ├── heads
    └── tags

```

## Exercises

1. Make a new folder
1. Run `git init`
1. Run `git status`
1. Read _How to Write a Git Commit Message_.

## References

1. [`git init`](https://git-scm.com/docs/git-init)
1. [`git status`](https://git-scm.com/docs/git-status)
1. [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)



# Your first commit

The sooner we talk about the three stages of _tracked_ files, the better:

1. Tracked, unchanged
1. Tracked, changes _**not** staged to be commited_
1. Tracked, changes _**staged** to be commited_
1. (... and of course the _untracked_ files)

When we have _added_ a file to the _git tree_, it is tracked.  If we change that
file, the file will immediately be marked as _changed_, but the changes are not
staged.  Before we can _commit_ the changes to the git tree, we need to _stage_
the changes, or `add` the changes.  We do this by running `git add a.txt`.  To
immediately _commit_ the changes, we run `git commit -m "Description/message of
change"`.

```bash
git add a.txt
git commit -m "Initial commit"
```

Which outputs

```
[master (root-commit) 1fe91d0] Initial commit
 1 file changed, 6 insertions(+)
 create mode 100644 a.txt
```



## Exercises

1. Create a text file with some content.
1. Run `git add` on the file
1. Run `git status`
1. Run `git commit -m "Initial commit"`


## References

1. [`git add`](https://git-scm.com/docs/git-add)
1. [`git commit`](https://git-scm.com/docs/git-commit)


# Browsing our history

A crucial part of using Git is to read the history of the project; it is after
all a revision control system.

## Exercises

1. Run `git log`
1. Run `git log -p`  (use `q` to quit if necessary)
1. Run `git log --oneline`


## References

1. [`git log`](https://git-scm.com/docs/git-log)


# Linear use of git

Now we are ready to use Git.

Open `a.txt` and add a couple of lines.

As many times as you need:

```
edit a.txt
git add a.txt
git diff
git status
git commit -m "Changed a.txt"
git status
git log --oneline
git log -p
```

## Exercises

1. Change a line, diff, status, add and commit, log
1. Delete a line, diff, status, add and commit, log
1. Add    a line, diff, status, add and commit, log
1. Write a longer file with at least three paragraphs, add and commit ...
1. ... then modify the file in the top and bottom paragraphs and run `git add -p`
1. Change top and bottom paragraph, add and commit _only the top changes_

## References

* [`git log`](https://git-scm.com/docs/git-log)
* [`git status`](https://git-scm.com/docs/git-status)
* [`git diff`](https://git-scm.com/docs/git-diff)
* [`git add`](https://git-scm.com/docs/git-add)
* [`git commit`](https://git-scm.com/docs/git-commit)


# Undoing changes

Being humans, one thing that will never change is that we make mistakes.  Like a
lot.  Sometimes we delete a file we didn't intend to delete, and sometimes we
change things we didn't want changed.  Git is super-helpful in these cases.
Even if we _commit the changes we didn't intend_, we can still navigate back to
the previous version we were happy with.

First of all, you should know that

```bash
git reset --hard
```

removes all your changes and everything you _added_ since last _commit_.  Hence,
if you commit often, you can always get back to a nearby state by running
`git reset --hard`.
But realize that this removes all your unsaved uncommited changes, which might
not be what you want.



**Reverting all the changes**

Let's say you delete `a.txt` and maybe overwrite `b.txt` with some garbage that
you didn't intend to.  If there is no other change you need to keep since the
previous commit, you run

```bash
git reset --hard
```

However, that resets _everything_.  Sometimes you want to keep some of the
changes (say, the changes to `b.txt`), but you might still want to recover
`a.txt`.  The simplest way out is to run

```bash
git add b.txt
git commit -m "Saving changes to b"
git reset --hard
```

Now, since we saved the changes to `b.txt`, the `reset --hard` restores `a.txt`,
but leaves `b.txt` as it is in the commit.

**Undoing a staging (an `add`)**

Suppose that you change `b.txt` and stage the changes with `git add b.txt`, but
immediately regrets staging them.  By running

```bash
git reset
```

we _unstage_ everything.  We can also run `git reset b.txt` to reset _only_
`b.txt`.  In some sense, `git reset <path>` is the opposite action of `git add <path>`.



**Undoing a commit**

Sometimes we even _commit_ a staged change by accident, or after review, we
realize that we have commited an error.  We can _roll back to a previous
commit_, however, this should be done only locally, or in other special
circumstances.

If we have this history:
```
* be70d88 (HEAD -> master) Add c
* 434bbc2 Add b
* d52b990 Initial long commit
* 4468f5d Initial commit
```

then `git reset --hard 434bbc2` results in this tree:

```
* 434bbc2 (HEAD -> master) Add b
* d52b990 Initial long commit
* 4468f5d Initial commit
```


## Exercises

1. Delete `a.txt` with `rm a.txt` and run `git status`.  Revert the change with `git reset --hard`.
1. Stage changes in several files, unstage only one of the file changes.
1. Unstage everything, and stage with `git add -p`
1. Commit and roll back to a previous commit.

## References

* [`git reset`](https://git-scm.com/docs/git-reset)


# Branches in git

A commit is, as we have seen, a `diff` between different versions of files, and
_commits form the base of `git`_.  A _commit_ lives in a _branch_.

When we ran `git init`, we started with a branch called `master`.  While we add
and commit, we commit _to `master`_.

We can _branch out from `master`_ to create new commits that are "separate" from
the commits we have on `master` by using `git branch`:

```bash
git branch my_first_branch
```

The `branch` command adds a _new branch_ called `my_first_branch`, and if we run
`git branch` now, we will see that we have two branches, `master` and
`my_first_branch`.  The next step is to _go to_ the new branch:

```bash
git checkout my_first_branch
```

This takes us to the new branch that branched our from _`HEAD`_ on `master`, and
if we run `git log`, we will see that we are on `my_first_branch`.

When we now change a file, and add and commit it, we can see from the `log`,
that `my_first_branch` has moved beyond `master`, by running `git log`:

```
* f308559 (HEAD -> my_first_branch) Add line on new branch
* 1fe91d0 (master) Initial commit
```


**Merging a branch into `master`**

When we work with a branch, we usually intend to _merge_ the branch with the
master branch (but not always).

Run `git branch` to ensure that we are on `master`.  Run `git checkout -b
new_branch` and make changes to `a.txt`.  Stage and commit the changes, and
check out `master`.

_Observe_ that we have two different versions of `a.txt`.

When we want to merge `new_branch` _into_ `master`, we simply write

```bash
git merge new_branch
```

This was _a very simple merge_, which resulted only in a _fast-forward_.

Let us make a more complicated merge.  Check out a new branch, called
`second_branch`.  Change `a.txt` (and stage and commit) in the top of the file!
Go back to `master` and change `a.txt` at the bottom of the file (stage &
commit).  Observe that we have _two different (changed) versions of `a.txt`_ in
the two branches.

Go to `master` and again run `git merge second_branch`.

At this point, `git` will **create a new commit** for you, called a _merge
commit_.  You are asked to provide a commit message, but the default

> `Merge branch 'second_branch'`

is a good message, so we keep that.

Git will now do an _auto-merge_.

At this point, it can be illuminating to run

```bash
git log --oneline --graph
```

```git
*   5d7576b (HEAD -> master) Merge branch 'second_branch'
|\
| * 039842c (second_branch) Change in second to a
* | ff20c97 Change in master to a
|/
* 02c02bc Add changes to file on master
* cf6489e (new_branch) Add change in new_branch
* f8213a3 Add file c
* 434bbc2 Add b
* d52b990 Initial long commit
* 4468f5d Initial commit
```


**Merge conflicts**

It is at this point recommended to breath, enter lotus position, revisit the
previous exercises and embrace.  We will _provoke a **CONFLICT**_ in `git`.

As you saw in the previous section, `git` could easily merge the changes,
because they touched completely different parts of the file.  Git manages to
keep both changes, and no data/change is lost.

But what if we have two files that change _the same line_‽

Let us check out yet another branch, `git checkout -b future-confl`.  Edit any
line in `a.txt` and commit.  Go back to master and edit _the same line in
`a.txt` but in a different way_.  Now **let's merge**!

```
$ git merge future-confl
Auto-merging a
CONFLICT (content): Merge conflict in a
Automatic merge failed; fix conflicts and then commit the result.
```

Run `git status` to see what is going on:

```
On branch master
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)

	both modified:   a.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

We are now in a _conflict_ state, which we can easily get out of by running `git
add a.txt` and `git commit`.  But first, let's inspect `a.txt`.

```
git diff
  The text above the change ...
++<<<<<<< HEAD
 +this line was changed in master.
++=======
+ whereas this line was changed in future_confl.
++>>>>>>> future-confl
  this is some more text ...
```

What we can see here, is that `git` informs us that _we have to choose_ which
change we want, or more precisely, _how we want `a.txt` to look_ on `master`.

Let's go into the `a.txt` file and fix the _conflict_.  Run `git add a.txt` and
`git commit`.  Again we are prompted with a commit message, and again the
default is ok,

> `Merge branch 'future-confl'`

Again we can run `git log --oneline --graph` to see our work:

```
*   20bb70d (HEAD -> master) Merge branch 'future-confl'
|\
| * a80f35e (future-confl) Change a in future-confl
* | 80ca334 Change a in master
|/
*   5d7576b Merge branch 'second_branch'
|\
| * 039842c (second_branch) Change in second to a
* | ff20c97 Change in master to a
|/
* 02c02bc Add changes to file on master
* cf6489e (new_branch) Add change in new_branch
* f8213a3 Add file c
* 434bbc2 Add b
* d52b990 Initial long commit
* 4468f5d Initial commit
```

We have successfully _provoked_ a **conflict** as well as _resolved_ it.

Take away message: A conflict is Git telling us that she doesn't know which
change you want to keep, because you changed the same part in both branches you
want to merge.  Git then asks you to manually pick how the result should look,
and when you are happy, you simply stage & commit.


## Exercises

1. Create a new branch
1. Jump between branches
1. Change the file in one branch, add, commit, observe the file in the different branches
1. Merge the branch _into_ `master`
1. Create a new branch, and change `a.txt` in the top.  Go back to master and
   change it in the bottom parts.  Merge.
1. Create a new branch, change the same parts in both master and the new branch.
   Merge and resolve conflicts.
1. Create a different branch, make a commit, go back to master and `cherry-pick` the commit in.
1. Read the manual entry for `git rebase`.
1. Python exercise:  Create a file `cc.py` with the following content
   ```python
   def count_chars(fname, char):
       count = 0
       with open(fname, "r") as f:
           for line in f:
               count += line.count(char)
       return count


   if __name__ == "__main__":
       from sys import argv

       print(count_chars(argv[1], argv[2]))
   ```
   Create a branch, one where you change `fname` to `filename` (both places), and
   on `master`, you change `count_chars` to `count_character` (both places).

   Merge the changes into one working Python script containing both changes.

   Ensure that the script work by running
   ```
   $ python cc.py cc.py i
   10
   $ python cc.py cc.py a
   14
   ```


## References

1. [`git branch`](https://git-scm.com/docs/git-branch)
1. [`git merge`](https://git-scm.com/docs/git-merge)
1. [`git rebase`](https://git-scm.com/docs/git-rebase)
1. [`git cherry-pick`](https://git-scm.com/docs/git-cherry-pick)


# Remotes

We are now actually at a level where we can use Git for everything, but we have
not used it as a collaborative tool.  It is actually possible to use it
productively by sending the changes (commits and even full branches) via
_email_, however, it is possible to use a common _server_, or in Git called
_remote_, to share a Git tree.
(See note.)

Suppose that you (Alice) are working with Bob on the same Git tree, and the Git
tree are stored on a _Git server_ with URL
`https://example.com/git/project.git`.

You can _add_ that URL as a _remote_ for your git tree by using

```
git remote add origin https://example.com/git/project.git
```

The name `origin` here is _arbitrary_ but standard.  There is also a Git
protocol which is based on `ssh`, in which the URL above would look like
`git://example.com:git/project.git`.

We could add such a remote (choosing a different name now) with

```
git remote add upstream git://example.com:git/project.git
```


**Cloning an existing repo**

If the repository already exists on the server, you more likely would want to
_clone_ the repository:

```
git clone git://example.com:git/project.git
```



**Note on `ssh` vs `https`**

When using the `https` protocol, we are prompted with a _login_ prompt whenever
we want to interact with the server, of the kind

```
username:
password:
```

However, in today's era, we very often recommend the use of _two-factor
authentication_ (2FA), and as you maybe can imagine, this prompt rarely works
well with 2FA.  Hence, if you have enabled 2FA on your Git server, you should
not be surprised if you run into problems using the `https` protocol.

We therefore recommend you use the `ssh` protocol.  The `ssh` protocol is based
on a _private/public key_ (asymmetric encryption), where you generate _two
keys_, one that you keep secret (your private key), and one you give to the Git
server (and everyone else in the world, your public key).

There is a [tutorial on GitHub.com for _Generating a new SSH key and adding it
to the
ssh-agent_](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

As long as you keep the private key secret, this is a very good and secure way
of working with Git.  You can add several keys, one for each computer you use.

It is also possible to use HTTPS without 2FA, but with a [_personal access
tokens_](https://github.com/settings/tokens) instead of the password.  In this
case, your username is your GitHub username, and the password to use is the
token.  Beware that you need to take care to not leak the token, since that is a
stand-in for password+2FA.


**Fetching, pulling, and pushing**

To _push_ your tree to the server, you simply write `git push`.

To _fetch_ the tree on the server, you run `git fetch`.

If you want to _fetch and "merge"_ the changes on the server, you run `git
pull`.


## Exercises

1. Clone any Git repository and run `git log`

## Notes

1. A _remote_ is not necessarily stored on a server.  Indeed, you can actually
   _clone_ a repository on your local (or remote) harddrive.  Simply make a new
   folder and write `git clone /path/to/repo`.

## References

* [`git clone`](https://git-scm.com/docs/git-clone)
* [`git remote`](https://git-scm.com/docs/git-remote)
* [`git push`](https://git-scm.com/docs/git-push)
* [`git fetch`](https://git-scm.com/docs/git-fetch)
* [`git pull`](https://git-scm.com/docs/git-pull)
* [Generating a new SSH key](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

# Git commands

* Setup and Config
  * [`git config`](https://git-scm.com/docs/git-config)
  * [`git help`](https://git-scm.com/docs/git-help)
* Getting and Creating Projects
  * [`git init`](https://git-scm.com/docs/git-init)
  * [`git clone`](https://git-scm.com/docs/git-clone)
* Basic Snapshotting
  * [`git add`](https://git-scm.com/docs/git-add)
  * [`git status`](https://git-scm.com/docs/git-status)
  * [`git diff`](https://git-scm.com/docs/git-diff)
  * [`git commit`](https://git-scm.com/docs/git-commit)
  * [`git notes`](https://git-scm.com/docs/git-notes)
  * [`git restore`](https://git-scm.com/docs/git-restore)
  * [`git reset`](https://git-scm.com/docs/git-reset)
  * [`git rm`](https://git-scm.com/docs/git-rm)
  * [`git mv`](https://git-scm.com/docs/git-mv)
  * [`git clean`](https://git-scm.com/docs/git-clean)
* Branching and Merging
  * [`git branch`](https://git-scm.com/docs/git-branch)
  * [`git checkout`](https://git-scm.com/docs/git-checkout)
  * [`git switch`](https://git-scm.com/docs/git-switch)
  * [`git merge`](https://git-scm.com/docs/git-merge)
  * [`git mergetool`](https://git-scm.com/docs/git-mergetool)
  * [`git log`](https://git-scm.com/docs/git-log)
  * [`git stash`](https://git-scm.com/docs/git-stash)
  * [`git tag`](https://git-scm.com/docs/git-tag)
  * [`git worktree`](https://git-scm.com/docs/git-worktree)
* Sharing and Updating Projects
  * [`git fetch`](https://git-scm.com/docs/git-fetch)
  * [`git pull`](https://git-scm.com/docs/git-pull)
  * [`git push`](https://git-scm.com/docs/git-push)
  * [`git remote`](https://git-scm.com/docs/git-remote)
  * [`git submodule`](https://git-scm.com/docs/git-submodule)
* Inspection and Comparison
  * [`git show`](https://git-scm.com/docs/git-show)
  * [`git log`](https://git-scm.com/docs/git-log)
  * [`git diff`](https://git-scm.com/docs/git-diff)
  * [`git difftool`](https://git-scm.com/docs/git-difftool)
  * [`git range-diff`](https://git-scm.com/docs/git-range-diff)
  * [`git shortlog`](https://git-scm.com/docs/git-shortlog)
  * [`git describe`](https://git-scm.com/docs/git-describe)
* Patching
  * [`git apply`](https://git-scm.com/docs/git-apply)
  * [`git cherry-pick`](https://git-scm.com/docs/git-cherry-pick)
  * [`git diff`](https://git-scm.com/docs/git-diff)
  * [`git rebase`](https://git-scm.com/docs/git-rebase)
  * [`git revert`](https://git-scm.com/docs/git-revert)
* Debugging
  * [`git bisect`](https://git-scm.com/docs/git-bisect)
  * [`git blame`](https://git-scm.com/docs/git-blame)
  * [`git grep`](https://git-scm.com/docs/git-grep)
* Advanced usage
  * [`git filter-branch`](https://git-scm.com/docs/git-filter-branch)
  * [`git reflog`](https://git-scm.com/docs/git-reflog)


---

* Git browsing
  * [`git log`](https://git-scm.com/docs/git-log)
  * [`git status`](https://git-scm.com/docs/git-status)
  * [`git diff`](https://git-scm.com/docs/git-diff)
  * [`git show`](https://git-scm.com/docs/git-show)
  * [`git blame`](https://git-scm.com/docs/git-blame)
  * [`git config`](https://git-scm.com/docs/git-config)
  * [`git help`](https://git-scm.com/docs/git-help)
* Linear basic git
  * [`git init`](https://git-scm.com/docs/git-init)
  * [`git add`](https://git-scm.com/docs/git-add)
  * [`git commit`](https://git-scm.com/docs/git-commit)
  * [`git reset`](https://git-scm.com/docs/git-reset)
  * [`git clean`](https://git-scm.com/docs/git-clean)
  * [`git rm`](https://git-scm.com/docs/git-rm)
  * [`git mv`](https://git-scm.com/docs/git-mv)
  * [`git restore`](https://git-scm.com/docs/git-restore)
  * [`git stash`](https://git-scm.com/docs/git-stash)
  * [`git tag`](https://git-scm.com/docs/git-tag)
  * [`git apply`](https://git-scm.com/docs/git-apply)
* Branching
  * [`git branch`](https://git-scm.com/docs/git-branch)
  * [`git checkout`](https://git-scm.com/docs/git-checkout)
  * [`git merge`](https://git-scm.com/docs/git-merge)
  * [`git rebase`](https://git-scm.com/docs/git-rebase)
  * [`git cherry-pick`](https://git-scm.com/docs/git-cherry-pick)
* Advanced usage
  * [`git filter-branch`](https://git-scm.com/docs/git-filter-branch)
  * [`git bisect`](https://git-scm.com/docs/git-bisect)
  * [`git reflog`](https://git-scm.com/docs/git-reflog)
* Remote work
  * [`git clone`](https://git-scm.com/docs/git-clone)
  * [`git remote`](https://git-scm.com/docs/git-remote)
  * [`git push`](https://git-scm.com/docs/git-push)
  * [`git fetch`](https://git-scm.com/docs/git-fetch)
  * [`git pull`](https://git-scm.com/docs/git-pull)

---


Copyright 2020 Equinor ASA, (cc-by-4.0)
